import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/data/auth/repository/auth_repository.dart';
import 'package:instagram/data/auth/repository/post_repository.dart';
import 'package:instagram/models/post.dart';
import 'package:instagram/screen/addPost/bloc/add_post_bloc.dart';
import 'package:instagram/screen/home/home_screen.dart';
import 'package:instagram/services/storage_firebase.dart';
import 'package:instagram/utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  StreamSubscription? streamSubscriptionBloc;
  bool isLoading = false;
  Uint8List? post;
  selectImage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(title: const Text("Create a Post"), children: [
          SimpleDialogOption(
            onPressed: () async {
              Navigator.of(context).pop();

              Uint8List file = await pickImage(ImageSource.camera);
              setState(() {
                post = file;
              });
            },
            padding: const EdgeInsets.all(20),
            child: const Text("Take a Photo"),
          ),
          SimpleDialogOption(
            onPressed: () async {
              Navigator.of(context).pop();

              Uint8List file = await pickImage(ImageSource.gallery);
              setState(() {
                post = file;
              });
            },
            padding: const EdgeInsets.all(20),
            child: const Text("Select from Gallery"),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(context).pop();
            },
            padding: const EdgeInsets.all(20),
            child: const Text("Cancell"),
          ),
        ]);
      },
    );
  }

  @override
  void dispose() {
    streamSubscriptionBloc?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController caption = TextEditingController();
    return post == null
        ? Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Enter for add new post"),
              IconButton(
                  onPressed: () => selectImage(context),
                  icon: const Icon(Icons.upload_file)),
            ]),
          )
        : BlocProvider(
            create: (context) {
              final bloc = AddPostBloc(postRepository, authRepository);
              bloc.add(AddPostSrarted());
              streamSubscriptionBloc = bloc.stream.listen((state) {
                if (state is AddPostSuccess) {
                  isLoading = false;
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.messageSuccess)));
                  post = null;
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddPostScreen(),
                  ));
                } else if (state is AddPostError) {
                  isLoading = false;

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.appException.messageError)));
                }
              });
              return bloc;
            },
            child: BlocBuilder<AddPostBloc, AddPostState>(
              builder: (context, state) {
                if (state is AddPostInitial) {
                  return Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddPostScreen(),
                            ));
                          },
                          icon: const Icon(Icons.arrow_back)),
                      title: const Text("Add Post"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              if (post != null) {
                                BlocProvider.of<AddPostBloc>(context).add(
                                    AddPostButtonClicked(
                                        PostRequest(
                                            state.user!.userName,
                                            state.user!.uid,
                                            caption.text,
                                            state.user!.pohtoUrl),
                                        post!));
                              } else {
                                ScaffoldMessengerState().showSnackBar(
                                    const SnackBar(
                                        content: Text("Add your photo")));
                              }
                              setState(() {
                                isLoading = true;
                              });
                            },
                            child: const Text(
                              "Post",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ))
                      ],
                    ),
                    body: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        isLoading
                            ? const LinearProgressIndicator()
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  state.user!.pohtoUrl,
                                ),
                                // radius: 27,
                              ),
                              // const SizedBox(
                              //   width: 30,
                              // ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextField(
                                    controller: caption,
                                    decoration: InputDecoration(
                                      fillColor: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      hintText: "Write caption ...",
                                    )),
                              ),
                              SizedBox(
                                width: 45,
                                height: 45,
                                child: AspectRatio(
                                  aspectRatio: 487 / 451,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          alignment: Alignment.topCenter,
                                          image: MemoryImage(post!),
                                        )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } else if (state is AddPostLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is AddPostError) {
                  return Center(
                    child: Text(state.appException.messageError),
                  );
                } else {
                  return Container();
                }
              },
            ),
          );
  }
}

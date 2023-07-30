import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:instagram/models/signup.dart';
import 'package:instagram/screen/home/home_screen.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/data/auth/repository/auth_repository.dart';
import 'package:instagram/models/user.dart';
import 'package:instagram/screen/auth/login/login_screen.dart';
import 'package:instagram/screen/auth/signUp/bloc/signup_bloc.dart';
import 'package:instagram/utils/utils.dart';
import 'package:instagram/widgets/text_field.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Uint8List? image;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController bio = TextEditingController();
  StreamSubscription? streamSubscription;

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    bio.dispose();
    streamSubscription?.cancel();
    super.dispose();
  }

  void defaultImage() async {
    File f = await getImageFileFromAssets('img/unKnown.png');
    Uint8List imag = await f.readAsBytes();
    setState(() {
      image = imag;
    });
  }

  void setImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      if (img.isNotEmpty) {
        image = img;
      }
    });
  }

  @override
  void initState() {
    defaultImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SignupBloc>(
        create: (context) {
          final bloc = SignupBloc(authRepository);

          streamSubscription = bloc.stream.listen((state) {
            if (state is SignupSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.result)));
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
            } else if (state is SignupError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.appExeption.messageError)));
            }
          });
          return bloc;
        },
        child: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            height: 860,
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(),
                ),
                SvgPicture.asset(
                  "assets/img/ic_instagram.svg",
                  height: 64,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                const SizedBox(
                  height: 64,
                ),
                Stack(
                  children: [
                    image != null
                        ? CircleAvatar(
                            backgroundImage: MemoryImage(image!),
                            radius: 64,
                          )
                        : const CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/img/unKnown.png"),
                            radius: 64,
                          ),
                    Positioned(
                      bottom: -12,
                      left: 83,
                      child: IconButton(
                        onPressed: setImage,
                        icon: const Icon(
                          Icons.add_a_photo,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFieldInput(
                    textEditingController: username,
                    hintText: "Enter your Username",
                    obsureText: false,
                    textInputType: TextInputType.emailAddress),
                const SizedBox(
                  height: 16,
                ),
                TextFieldInput(
                    textEditingController: email,
                    hintText: "Enter your Email",
                    obsureText: false,
                    textInputType: TextInputType.emailAddress),
                const SizedBox(
                  height: 16,
                ),
                TextFieldInput(
                    textEditingController: password,
                    hintText: "Enter your Password",
                    obsureText: true,
                    textInputType: TextInputType.visiblePassword),
                const SizedBox(
                  height: 16,
                ),
                TextFieldInput(
                    textEditingController: bio,
                    hintText: "Enter your Bio",
                    obsureText: false,
                    textInputType: TextInputType.visiblePassword),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: BlocBuilder<SignupBloc, SignupState>(
                      builder: (context, state) {
                        return ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<SignupBloc>(context).add(
                                  ClickToSignUp(SignUpEntity(
                                      username.text,
                                      password.text,
                                      email.text,
                                      bio.text,
                                      image!)));
                            },
                            child: state is SignupLoading
                                ? const CupertinoActivityIndicator()
                                : const Text("Sign up"));
                      },
                    )),
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Do you have account ?"),
                      const SizedBox(
                        width: 6,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                        },
                        child: Text(
                          "Log in",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}

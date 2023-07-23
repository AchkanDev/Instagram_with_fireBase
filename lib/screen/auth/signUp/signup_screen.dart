import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/screen/auth/login/login_screen.dart';
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

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    bio.dispose();
    super.dispose();
  }

  void setImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
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
                        backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1684620862250-287cb4543b46?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80"),
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
                textEditingController: username,
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
                textEditingController: password,
                hintText: "Enter your Bio",
                obsureText: true,
                textInputType: TextInputType.visiblePassword),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                    onPressed: () {}, child: const Text("Sign up"))),
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
      )),
    );
  }
}

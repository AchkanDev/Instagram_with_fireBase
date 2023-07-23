import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/screen/auth/signUp/signup_screen.dart';
import 'package:instagram/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
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
              child: Container(),
              flex: 1,
            ),
            SvgPicture.asset(
              "assets/img/ic_instagram.svg",
              height: 64,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            const SizedBox(
              height: 64,
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
                textEditingController: password,
                hintText: "Enter your Password",
                obsureText: true,
                textInputType: TextInputType.visiblePassword),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                    onPressed: () {}, child: const Text("Log In"))),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have account ?"),
                const SizedBox(
                  width: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ));
                    },
                    child: Text(
                      "Sign Up",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}

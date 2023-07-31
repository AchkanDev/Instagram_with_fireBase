import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/data/auth/repository/auth_repository.dart';
import 'package:instagram/screen/auth/login/bloc/login_bloc.dart';
import 'package:instagram/screen/auth/signUp/signup_screen.dart';
import 'package:instagram/screen/home/home_screen.dart';
import 'package:instagram/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  StreamSubscription? streamSubscription;
  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) {
          final bloc = LoginBloc(authRepository);
          streamSubscription = bloc.stream.listen((state) {
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.success)));
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
            } else if (state is LoginError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.appException.messageError)));
            }
          });
          return bloc;
        },
        child: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 90,
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
                    hintText: "Enter your email addres",
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
                    child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<LoginBloc>(context).add(
                                  ClickToLogin(username.text, password.text));
                            },
                            child: state is LoginLoading
                                ? const CupertinoActivityIndicator()
                                : const Text("Login"));
                      },
                    )),
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
          ),
        )),
      ),
    );
  }
}

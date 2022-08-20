import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Widgets/SignInScreen/sign_in_action.dart';
import 'package:social_app/Widgets/SignInScreen/sign_in_input_fields.dart';

class SignInBody extends StatelessWidget {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  SignInBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> loginKey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: loginKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SignInInputFields(
                  emailController: emailController,
                  passwordController: passwordController),
              SignInActions(
                  emailController: emailController,
                  passwordController: passwordController,
                  loginKey: loginKey),
            ],
          ),
        ),
      ),
    );
  }
}

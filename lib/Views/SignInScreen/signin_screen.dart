import 'package:flutter/material.dart';

import '../../Widgets/SignInScreen/sign_in_action.dart';
import '../../Widgets/SignInScreen/sign_in_input_fields.dart';
import '../../Widgets/SignInScreen/sign_in_welcome_message.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var emailController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40,),
                const WelcomeMessage(),
                const SizedBox(
                  height: 50,
                ),
                SignInInputFields(
                    emailController: emailController,
                    passwordController: passwordController),
                const SizedBox(
                  height: 30,
                ),
                SignInActions(
                    emailController: emailController,
                    passwordController: passwordController)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

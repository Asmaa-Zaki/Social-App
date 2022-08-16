import 'package:flutter/material.dart';
import 'package:social_app/Widgets/SignUpScreen/sign_up_action.dart';
import 'package:social_app/Widgets/SignUpScreen/sign_up_input_fields.dart';

import '../../Widgets/SignUpScreen/sign_up_welcome_message.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SignUpWelcomeMessage(),
                SignUpInputFields(
                    passwordController: passwordController,
                    emailController: emailController,
                    nameController: nameController,
                    phoneController: phoneController),
                SignUpActions(
                    passwordController: passwordController,
                    emailController: emailController,
                    nameController: nameController,
                    phoneController: phoneController)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

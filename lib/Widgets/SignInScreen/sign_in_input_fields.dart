import 'package:flutter/material.dart';

import '../SharedWidgets/BuildText/build_text_form_field.dart';

class SignInInputFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const SignInInputFields({Key? key, required this.emailController, required this.passwordController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Email",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        BuildTextFormField(
            controller: emailController,
            label: "Email",
            keyboard: TextInputType.emailAddress,
            preFix: Icons.email,
            validate: (val) {
              if (val!.isEmpty) {
                return "Email is Required";
              }
              return null;
            }),
        const SizedBox(
          height: 30,
        ),
        const Text(
          "Password",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        BuildTextFormField(
            controller: passwordController,
            label: "Password",
            obscureText: true,
            preFix: Icons.email,
            postFix: Icons.visibility,
            validate: (val) {
              if (val!.isEmpty) {
                return "Password is Required";
              }
              return null;
            }),
      ],
    );
  }
}

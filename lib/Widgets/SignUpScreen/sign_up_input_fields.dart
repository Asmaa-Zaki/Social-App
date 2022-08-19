import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../SharedWidgets/BuildText/build_text_form_field.dart';

class SignUpInputFields extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController phoneController;

  const SignUpInputFields(
      {Key? key,
      required this.passwordController,
      required this.emailController,
      required this.nameController,
      required this.phoneController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        const Text(
          "Name",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        BuildTextFormField(
            controller: nameController,
            label: "Name",
            preFix: Icons.person,
            validate: (val) {
              if (val!.isEmpty) {
                return "Name is Required";
              }
              return null;
            }),
        const SizedBox(
          height: 30,
        ),
        const Text(
          "Email",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
          "Phone",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        BuildTextFormField(
            controller: phoneController,
            label: "Phone",
            keyboard: TextInputType.phone,
            preFix: Icons.phone,
            validate: (val) {
              if (val!.isEmpty) {
                return "Phone is Required";
              }
              return null;
            }),
        const SizedBox(
          height: 30,
        ),
        const Text(
          "Password",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

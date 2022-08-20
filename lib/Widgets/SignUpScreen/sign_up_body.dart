import 'package:flutter/material.dart';

import 'sign_up_action.dart';
import 'sign_up_input_fields.dart';

class SignUpBody extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  SignUpBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
    return Form(
      key: signUpKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SignUpInputFields(
                passwordController: passwordController,
                emailController: emailController,
                nameController: nameController,
                phoneController: phoneController),
            SignUpActions(
                passwordController: passwordController,
                emailController: emailController,
                nameController: nameController,
                phoneController: phoneController,
                signUpKey: signUpKey),
          ],
        ),
      ),
    );
  }
}

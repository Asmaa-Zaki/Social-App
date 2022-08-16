import 'package:flutter/material.dart';

class SignUpWelcomeMessage extends StatelessWidget {
  const SignUpWelcomeMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
          "Hello Sign Up To use our App",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontStyle: FontStyle.italic),
        ));
  }
}

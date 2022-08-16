import 'package:flutter/material.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
          "Hello Sign In To use our App",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontStyle: FontStyle.italic),
        ));
  }
}

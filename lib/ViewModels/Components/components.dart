import 'package:flutter/material.dart';

Future<dynamic> buildPushReplacement(BuildContext context, Widget screen) {
  return Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) {
    return screen;
  }));
}

Future<dynamic> buildPush(BuildContext context, Widget screen) {
  return Navigator.push(context, MaterialPageRoute(builder: (context) {
    return screen;
  }));
}

void showSnackBar(BuildContext context, String message) {
  SnackBar snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

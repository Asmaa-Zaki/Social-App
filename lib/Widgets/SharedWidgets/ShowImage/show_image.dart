import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  final String url;
  const ShowImage(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: Image.network(url)),
    );
  }
}

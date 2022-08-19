import 'package:flutter/material.dart';

class BottomCurveOne extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(size.width * -0.0009500, size.height * -0.0009667);
    path0.lineTo(0, size.height);
    path0.quadraticBezierTo(size.width * 1.5159500, size.height * 1.0113333,
        size.width * 1.0009500, size.height * 0.9976333);
    path0.cubicTo(
        size.width * 0.7323250,
        size.height * 0.9834667,
        size.width * 0.5933000,
        size.height * 0.5793000,
        size.width * 0.5000000,
        size.height * 0.3731000);
    path0.quadraticBezierTo(size.width * 0.3710000, size.height * 0.0633333,
        size.width * -0.0009500, size.height * 0.0191000);
    path0.lineTo(size.width * -0.0009500, size.height * -0.0009667);
    path0.close();

    return path0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

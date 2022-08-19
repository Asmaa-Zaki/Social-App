import 'package:flutter/material.dart';

class BottomCurveTwo extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(0, size.height);
    path0.lineTo(size.width, size.height);
    path0.quadraticBezierTo(size.width * 1.0025000, size.height * 0.2833333,
        size.width, size.height * 0.4500000);
    path0.cubicTo(
        size.width * 0.9587500,
        size.height * 0.4491667,
        size.width * 0.7031250,
        size.height * 0.7250000,
        size.width * 0.3925000,
        size.height * 0.7500000);
    path0.cubicTo(
        size.width * 0.0625000,
        size.height * 0.7566667,
        size.width * 0.0018750,
        size.height * 0.5458333,
        0,
        size.height * 0.5633333);
    path0.quadraticBezierTo(
        size.width * -0.0012500, size.height * 0.4716667, 0, 0);
    path0.close();

    return path0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

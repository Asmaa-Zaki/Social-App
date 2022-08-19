import 'package:flutter/material.dart';

class TopCurveTwo extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width, 0);
    path0.quadraticBezierTo(size.width, size.height * 0.6200000, size.width,
        size.height * 0.8266667);
    path0.cubicTo(
        size.width * 0.8662500,
        size.height * 0.8258333,
        size.width * 0.6806250,
        size.height * 0.7483333,
        size.width * 0.4950000,
        size.height * 0.5300000);
    path0.cubicTo(
        size.width * 0.2700000,
        size.height * 0.2466667,
        size.width * 0.0143750,
        size.height * 0.2291667,
        0,
        size.height * 0.2400000);
    path0.quadraticBezierTo(
        size.width * 0.0012500, size.height * 0.1650000, 0, 0);
    path0.close();

    return path0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

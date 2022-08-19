import 'package:flutter/material.dart';

class TopCurveOne extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width, 0);
    path0.quadraticBezierTo(size.width, size.height * 0.7508333, size.width,
        size.height * 0.9966667);
    path0.cubicTo(
        size.width * 0.7318750,
        size.height * 0.9825000,
        size.width * 0.5931250,
        size.height * 0.5791667,
        size.width * 0.5000000,
        size.height * 0.3733333);
    path0.quadraticBezierTo(size.width * 0.3712500, size.height * 0.0641667, 0,
        size.height * 0.0200000);
    path0.lineTo(0, 0);
    path0.close();

    return path0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

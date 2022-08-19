import 'package:flutter/material.dart';

import '../../../ViewModels/Constants/constants.dart';
import '../../../Views/Curves/LoginAndSign/bottom_curve_one.dart';
import '../../../Views/Curves/LoginAndSign/bottom_curve_two.dart';

class BottomCurves extends StatelessWidget {
  const BottomCurves({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: BottomCurveOne(),
          child: Container(
            color: firstDefaultColor,
          ),
        ),
        ClipPath(
          clipper: BottomCurveTwo(),
          child: Container(
            width: double.infinity,
            color: secondDefaultColor.withOpacity(.1),
          ),
        ),
      ],
    );
  }
}

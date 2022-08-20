import 'package:flutter/material.dart';

import '../../../ViewModels/Constants/constants.dart';
import '../../../Views/Curves/LoginAndSign/top_curve_one.dart';
import '../../../Views/Curves/LoginAndSign/top_curve_two.dart';

class TopCurves extends StatelessWidget {
  final String headerText;
  const TopCurves({Key? key, required this.headerText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: TopCurveOne(),
          child: Container(
            color: firstDefaultColor,
          ),
        ),
        ClipPath(
          clipper: TopCurveTwo(),
          child: Container(
            width: double.infinity,
            color: secondDefaultColor.withOpacity(.1),
          ),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              headerText,
              style: TextStyle(
                  color: secondDefaultColor.withOpacity(.8),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

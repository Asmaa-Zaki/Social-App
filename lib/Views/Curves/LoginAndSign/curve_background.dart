import 'package:flutter/material.dart';

import '../../../Widgets/SharedWidgets/SignAndRegisterCurves/bottom_curves.dart';
import '../../../Widgets/SharedWidgets/SignAndRegisterCurves/top_curves.dart';

class CurveBackground extends StatelessWidget {
  final String headerText;

  const CurveBackground({Key? key, required this.headerText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 2,
            child: TopCurves(
              headerText: headerText,
            )),
        const Expanded(flex: 4, child: SizedBox()),
        const Expanded(flex: 1, child: BottomCurves())
      ],
    );
  }
}

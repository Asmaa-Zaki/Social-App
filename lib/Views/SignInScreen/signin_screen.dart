import 'package:flutter/material.dart';
import 'package:social_app/Widgets/SharedWidgets/SignAndRegisterCurves/bottom_curves.dart';
import 'package:social_app/Widgets/SignInScreen/sign_in_body.dart';

import '../../Widgets/SharedWidgets/SignAndRegisterCurves/top_curves.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(flex: 3, child: TopCurves()),
          Expanded(flex: 5, child: SignInBody()),
          const Expanded(flex: 2, child: BottomCurves())
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:social_app/Widgets/SignUpScreen/sign_up_body.dart';

import '../Curves/LoginAndSign/curve_background.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        const CurveBackground(
          headerText: 'Register',
        ),
        Column(children: [
          const Expanded(
            flex: 4,
            child: SizedBox(),
          ),
          Expanded(
            flex: 10,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        Expanded(flex: 8, child: SignUpBody()),
                        const Expanded(flex: 2, child: SizedBox())
                      ],
                    )),
              ],
            ),
          ),
        ])
      ]),
    );
  }
}

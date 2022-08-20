import 'package:flutter/material.dart';
import 'package:social_app/Views/Curves/LoginAndSign/curve_background.dart';
import 'package:social_app/Widgets/SignInScreen/sign_in_body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        const CurveBackground(
          headerText: "Login",
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(flex: 4, child: SizedBox()),
            Expanded(
              flex: 10,
              child: CustomScrollView(slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      Expanded(flex: 8, child: SignInBody()),
                      const Expanded(flex: 2, child: SizedBox())
                    ],
                  ),
                )
              ]),
            ),
          ],
        ),
      ]),
    );
  }
}

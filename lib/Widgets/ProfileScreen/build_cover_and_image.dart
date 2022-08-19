import 'package:flutter/material.dart';

import '../../Models/UserModel/user_model.dart';

class CoverAndImage extends StatelessWidget {
  final UserModel? cubit;
  final BuildContext? context;
  const CoverAndImage(this.cubit, this.context, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 140,
              child: Image.network(
                cubit!.cover,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            )),
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CircleAvatar(
              radius: 56,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            CircleAvatar(
              radius: 55,
              backgroundImage: NetworkImage(cubit!.image),
            )
          ],
        )
      ],
    ));
  }
}

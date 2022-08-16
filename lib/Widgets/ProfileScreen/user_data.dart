import 'package:flutter/material.dart';
import 'package:social_app/Models/UserModel/user_model.dart';

import 'build_cover_and_image.dart';

class ProfileUserData extends StatelessWidget {
  final UserModel user;

  const ProfileUserData({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 190,
          child: CoverAndImage(user, context),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(user.dio),
        const SizedBox(
          height: 19,
        ),
      ],
    );
  }
}

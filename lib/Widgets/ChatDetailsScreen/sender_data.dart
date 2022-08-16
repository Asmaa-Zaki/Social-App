import 'package:flutter/material.dart';
import 'package:social_app/Models/UserModel/user_model.dart';

class SenderData extends StatelessWidget {
  final UserModel currentUser;
  const SenderData(this.currentUser, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(currentUser.image),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(currentUser.name),
      ],
    );
  }
}

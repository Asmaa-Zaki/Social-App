import 'package:flutter/material.dart';
import 'package:social_app/Models/UserModel/user_model.dart';

class UserData extends StatelessWidget {
  final UserModel user;
  final String dateTime;

  const UserData({Key? key, required this.user, required this.dateTime}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
          radius: 30,
          backgroundImage:
          NetworkImage(user.image)),
      title: Row(
        children: [
          Text(
            user.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            width: 5,
          ),
          const Icon(
            Icons.check_circle,
            color: Colors.blue,
            size: 15,
          ),
        ],
      ),
      subtitle: Text(dateTime),
      trailing: const Icon(Icons.more_horiz),
    );
  }
}

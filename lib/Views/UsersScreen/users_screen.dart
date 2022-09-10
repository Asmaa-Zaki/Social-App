import 'package:flutter/material.dart';
import 'package:social_app/Models/UserModel/user_model.dart';

import '../../Widgets/BuildUserList/build_user_list.dart';

class UsersScreen extends StatelessWidget {
  final List<UserModel> users;
  const UsersScreen({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Likes"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppUsers(
              users: users,
              startChat: false,
            )));
  }
}

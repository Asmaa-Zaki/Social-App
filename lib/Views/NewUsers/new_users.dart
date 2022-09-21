import 'package:flutter/material.dart';
import 'package:social_app/Widgets/BuildUserList/build_user_list.dart';

class NewUsersScreen extends StatelessWidget {
  const NewUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Users"),
      ),
      body: const Center(
        child: AppUsers(showLikes: false),
      ),
    );
  }
}

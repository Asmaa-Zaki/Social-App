import 'package:flutter/material.dart';

import '../../Widgets/BuildUserList/build_user_list.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats List"),
      ),
      body: const Center(
        child: AppUsers(),
      ),
    );
  }
}

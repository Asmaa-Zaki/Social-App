import 'package:flutter/material.dart';

import '../../Widgets/FriendsList/friends_list.dart';

class StartChatWithFriends extends StatelessWidget {
  const StartChatWithFriends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Friends Chat"),
      ),
      body: const Center(
        child: FriendsUsers(),
      ),
    );
  }
}

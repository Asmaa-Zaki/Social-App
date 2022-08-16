import 'package:flutter/material.dart';
import 'package:social_app/Widgets/ChatDetailsScreen/sender_message.dart';

import '../../Models/MessageModel/message_model.dart';
import '../../Models/UserModel/user_model.dart';
import 'receiver_message.dart';

class MessagesList extends StatelessWidget {
  final UserModel currentUser;
  final List<MessageModel> messages;
  const MessagesList(this.currentUser, this.messages, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
            reverse: true,
            itemBuilder: (context, index) {
              if (messages[index].receiverId == currentUser.uId) {
                return FriendMessage(messages[index].message, messages[index].dateTime.substring(10,16));
              } else {
                return CurrentUserMessage(messages[index].message, messages[index].dateTime.substring(10,16));
              }
            },
            separatorBuilder: (context, index) {
              return Container(
                height: 10,
              );
            },
            itemCount: messages.length));
  }
}

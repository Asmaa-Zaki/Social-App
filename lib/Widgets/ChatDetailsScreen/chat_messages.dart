import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_cubit.dart';
import 'package:social_app/Widgets/ChatDetailsScreen/sender_message.dart';

import '../../Models/MessageModel/message_model.dart';
import '../../Models/UserModel/user_model.dart';
import 'receiver_message.dart';

class MessagesList extends StatelessWidget {
  final UserModel receiver;
  final List<MessageModel> messages;
  const MessagesList(this.receiver, this.messages, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ConditionalBuilder(
      condition: messages.isNotEmpty,
      builder: (context) {
        return ListView.separated(
            physics: const BouncingScrollPhysics(),
            reverse: true,
            itemBuilder: (context, index) {
              if (messages[index].senderId ==
                  UserCubit.get(context).user?.uId) {
                return SenderMessage(
                    messageTxt: messages[index].message,
                    messageTime: messages[index].dateTime.substring(10, 16),
                    messageImage: messages[index].image);
              } else {
                return ReceiverMessage(
                    messageTxt: messages[index].message!,
                    messageTime: messages[index].dateTime.substring(10, 16),
                    messageImage: messages[index].image);
              }
            },
            separatorBuilder: (context, index) {
              return Container(
                height: 10,
              );
            },
            itemCount: messages.length);
      },
      fallback: (context) {
        return const Center(
          child: Text("Start Chat"),
        );
      },
    ));
  }
}

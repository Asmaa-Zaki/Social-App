import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Models/MessageModel/message_model.dart';
import 'package:social_app/Widgets/ChatDetailsScreen/chat_messages.dart';
import 'package:social_app/Widgets/ChatDetailsScreen/send_action.dart';

import '../../Models/UserModel/user_model.dart';
import '../../ViewModels/Bloc/ChatCubit/chat_cubit.dart';
import '../../ViewModels/Bloc/ChatCubit/chat_states.dart';
import '../../Widgets/ChatDetailsScreen/sender_data.dart';

class ChatsDetails extends StatelessWidget {
  final UserModel receiver;
  ChatsDetails(this.receiver, {Key? key}) : super(key: key);

  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      ChatCubit.get(context).getMessages(receiver.uId);
      return Scaffold(
        appBar: AppBar(
          title: ReceiverData(receiver),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2),
          child: Column(
            children: [
              BlocConsumer<ChatCubit, ChatStates>(
                builder: (context, state) {
                  List<MessageModel> messages = ChatCubit.get(context).messages;
                  messages = messages.reversed.toList();
                  return MessagesList(receiver, messages);
                },
                listener: (context, state) {},
              ),
              const SizedBox(
                height: 10,
              ),
              SendAction(receiver, false, messageController)
            ],
          ),
        ),
      );
    });
  }
}

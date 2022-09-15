import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_persistent_keyboard_height/flutter_persistent_keyboard_height.dart';
import 'package:social_app/Models/MessageModel/message_model.dart';
import 'package:social_app/Widgets/ChatDetailsScreen/send_action.dart';

import '../../Models/UserModel/user_model.dart';
import '../../ViewModels/Bloc/ChatCubit/chat_cubit.dart';
import '../../ViewModels/Bloc/ChatCubit/chat_states.dart';
import '../../Widgets/ChatDetailsScreen/ChatMessages/chat_messages.dart';
import '../../Widgets/ChatDetailsScreen/sender_data.dart';

class ChatsDetails extends StatelessWidget {
  final UserModel receiver;
  ChatsDetails(this.receiver, {Key? key}) : super(key: key);

  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      ChatCubit.get(context).getMessages(receiver.uId);
      return WillPopScope(
        onWillPop: () async {
          ChatCubit.get(context).changeEmojiState(true);
          return true;
        },
        child: Scaffold(
          key: ChatCubit.get(context).scaffoldKey,
          appBar: AppBar(
            title: ReceiverData(receiver),
          ),
          body: Column(
            children: [
              BlocConsumer<ChatCubit, ChatStates>(
                builder: (context, state) {
                  List<MessageModel> messages = ChatCubit.get(context).messages;
                  return MessagesList(receiver, messages);
                },
                listener: (context, state) {},
              ),
              const SizedBox(
                height: 10,
              ),
              SendAction(receiver, false),
              const SizedBox(
                height: 2,
              ),
              BlocBuilder<ChatCubit, ChatStates>(
                builder: (context, state) {
                  return Offstage(
                    offstage: ChatCubit.get(context).emojiHide,
                    child: SizedBox(
                      height:
                          PersistentKeyboardHeight.of(context).keyboardHeight,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

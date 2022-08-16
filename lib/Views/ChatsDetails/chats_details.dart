import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
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
  final UserModel currentUser;
  const ChatsDetails(this.currentUser, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatCubit>(
        create: (context) => ChatCubit(),
        child: Builder(builder: (context) {
          ChatCubit.get(context).getMessages(currentUser.uId);
          return BlocConsumer<ChatCubit, ChatStates>(
            builder: (context, state) {
              List<MessageModel> messages = ChatCubit.get(context).messages;
              messages = messages.reversed.toList();
              return ConditionalBuilder(
                  condition: state is! GetChatLoading,
                  builder: (context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: SenderData(currentUser),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 2),
                        child: Column(
                          children: [
                            MessagesList(currentUser, messages),
                            const SizedBox(
                              height: 10,
                            ),
                            SendAction(currentUser)
                          ],
                        ),
                      ),
                    );
                  },
                  fallback: (context) {
                    return const Center(child: CircularProgressIndicator());
                  });
            },
            listener: (context, state) {},
          );
        }));
  }
}

import 'package:flutter/material.dart';

import '../../Models/UserModel/user_model.dart';
import '../../ViewModels/Bloc/ChatCubit/chat_cubit.dart';

class SendAction extends StatelessWidget {
  final UserModel currentUser;
  const SendAction(this.currentUser, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();

    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius:
          const BorderRadiusDirectional.all(
              Radius.circular(10))),
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: TextFormField(
              decoration: const InputDecoration(
                  hintText: "Enter your message",
                  border: InputBorder.none),
              controller: messageController,
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                ChatCubit.get(context).sendMessage(
                    message: messageController.text,
                    receiverId: currentUser.uId,
                    dateTime:
                    DateTime.now().toString());
                messageController.text = "";
              },
            ),
          )
        ],
      ),
    );
  }
}

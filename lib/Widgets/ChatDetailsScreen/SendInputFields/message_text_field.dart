import 'package:flutter/material.dart';

import '../../../ViewModels/Bloc/ChatCubit/chat_cubit.dart';
import 'disabled_focus_node.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusNode disabledFocusNode = DisabledFocusNode();
    FocusNode enableFocusNode = FocusNode();
    return Expanded(
      child: TextFormField(
        focusNode: !ChatCubit.get(context).emojiHide
            ? disabledFocusNode
            : enableFocusNode,
        maxLines: null,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
            hintText: "Type Message",
            border: InputBorder.none),
        controller: ChatCubit.get(context).messageController,
        keyboardType: TextInputType.multiline,
        onChanged: (val) {
          ChatCubit.get(context).changeMessageIcon();
        },
        onTap: () {
          if (ChatCubit.get(context).emojiHide == false) {
            ChatCubit.get(context).changeEmojiState(true);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}

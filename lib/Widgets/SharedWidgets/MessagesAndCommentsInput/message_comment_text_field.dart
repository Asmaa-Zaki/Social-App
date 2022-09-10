import 'package:flutter/material.dart';

import '../../../ViewModels/Bloc/ChatCubit/chat_cubit.dart';
import '../../../ViewModels/Bloc/CommentCubit/comment_cubit.dart';
import 'disabled_focus_node.dart';

class MessageAndCommentTextField extends StatelessWidget {
  final bool message;
  const MessageAndCommentTextField({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusNode disabledFocusNode = DisabledFocusNode();
    FocusNode enableFocusNode = FocusNode();
    return Expanded(
      child: TextFormField(
        focusNode: (message
                ? !ChatCubit.get(context).emojiHide
                : !CommentCubit.get(context).emojiHide)
            ? disabledFocusNode
            : enableFocusNode,
        maxLines: null,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        autofocus: message ? false : CommentCubit.get(context).keyboardFocus,
        decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.white),
            hintText: message ? "Type Message" : "Type Comment",
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none),
        controller: message
            ? ChatCubit.get(context).messageController
            : CommentCubit.get(context).commentController,
        keyboardType: TextInputType.multiline,
        onChanged: (val) {
          message
              ? ChatCubit.get(context).changeMessageIcon()
              : CommentCubit.get(context).changeMessageIcon();
        },
        onTap: () {
          if (message) {
            if (ChatCubit.get(context).emojiHide == false) {
              ChatCubit.get(context).changeEmojiState(true);
              Navigator.pop(context);
            }
          } else {
            if (CommentCubit.get(context).emojiHide == false) {
              CommentCubit.get(context).changeEmojiState(true);
              Navigator.pop(context);
            }
          }
        },
      ),
    );
  }
}

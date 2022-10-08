import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:social_app/ViewModels/Bloc/ChatCubit/chat_states.dart';
import 'package:social_app/ViewModels/Bloc/CommentCubit/comment_states.dart';

import '../../../ViewModels/Bloc/ChatCubit/chat_cubit.dart';
import '../../../ViewModels/Bloc/CommentCubit/comment_cubit.dart';
import 'disabled_focus_node.dart';

class MessageAndCommentTextField extends StatelessWidget {
  final bool message;
  const MessageAndCommentTextField({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool rtl = false;
    FocusNode disabledFocusNode = DisabledFocusNode();
    FocusNode enableFocusNode = FocusNode();
    return BlocBuilder<CommentCubit, CommentStates>(
      builder: (context, state) => BlocBuilder<ChatCubit, ChatStates>(
        builder: (context, state) => Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: TextFormField(
              textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
              focusNode: (message
                      ? !ChatCubit.get(context).emojiHide
                      : !CommentCubit.get(context).emojiHide)
                  ? disabledFocusNode
                  : enableFocusNode,
              maxLines: null,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              autofocus:
                  message ? false : CommentCubit.get(context).keyboardFocus,
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
                rtl = intl.Bidi.detectRtlDirectionality(val);
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
          ),
        ),
      ),
    );
  }
}

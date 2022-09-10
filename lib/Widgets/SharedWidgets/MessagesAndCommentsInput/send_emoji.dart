import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/ViewModels/Bloc/CommentCubit/comment_cubit.dart';

import '../../../ViewModels/Bloc/ChatCubit/chat_cubit.dart';
import 'emoji_picker.dart';

class SendEmoji extends StatelessWidget {
  final bool message;
  const SendEmoji({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        message
            ? ChatCubit.get(context)
                .scaffoldKey
                .currentState
                ?.showBottomSheet((context) => EmojiPickerWidget(
                      message: message,
                    ))
            : CommentCubit.get(context)
                .scaffoldKey
                .currentState
                ?.showBottomSheet((context) => EmojiPickerWidget(
                      message: message,
                    ));

        SystemChannels.textInput.invokeMethod('TextInput.hide');
        message
            ? ChatCubit.get(context).changeEmojiState(false)
            : CommentCubit.get(context).changeEmojiState(false);
      },
      icon: const Icon(Icons.emoji_emotions),
      color: Colors.white,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/Widgets/ChatDetailsScreen/SendInputFields/emoji_picker.dart';

import '../../../ViewModels/Bloc/ChatCubit/chat_cubit.dart';

class SendEmoji extends StatelessWidget {
  const SendEmoji({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        ChatCubit.get(context)
            .scaffoldKey
            .currentState
            ?.showBottomSheet((context) => const EmojiPickerWidget());
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        ChatCubit.get(context).changeEmojiState(false);
      },
      icon: const Icon(Icons.emoji_emotions),
      color: Colors.white,
    );
  }
}

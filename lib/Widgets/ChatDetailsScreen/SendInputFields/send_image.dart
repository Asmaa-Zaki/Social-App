import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ViewModels/Bloc/ChatCubit/chat_cubit.dart';
import '../../../ViewModels/Bloc/ChatCubit/chat_states.dart';

class SendImage extends StatelessWidget {
  const SendImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatStates>(builder: (context, state) {
      if (ChatCubit.get(context).messageController.text.isEmpty) {
        return IconButton(
          icon: const Icon(
            Icons.image,
            color: Colors.white,
          ),
          onPressed: () {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
            ChatCubit.get(context).changeEmojiState(true);
            ChatCubit.get(context).openGallery();
          },
        );
      } else {
        return const Text("");
      }
    });
  }
}

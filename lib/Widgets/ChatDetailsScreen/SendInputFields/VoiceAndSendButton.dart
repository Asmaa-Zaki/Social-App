import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Models/UserModel/user_model.dart';
import '../../../ViewModels/Bloc/ChatCubit/chat_cubit.dart';
import '../../../ViewModels/Bloc/ChatCubit/chat_states.dart';
import '../../../ViewModels/Components/Components.dart';
import 'show_image_selected.dart';

class VoiceAndSendButton extends StatelessWidget {
  final UserModel receiver;
  final bool image;

  const VoiceAndSendButton(
      {Key? key, required this.receiver, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: BlocConsumer<ChatCubit, ChatStates>(builder: (context, state) {
        TextEditingController messageController =
            ChatCubit.get(context).messageController;

        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blueGrey[900],
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: messageController.text.isNotEmpty || image == true
                ? const Icon(Icons.send, color: Colors.white)
                : const Icon(Icons.keyboard_voice, color: Colors.white),
            onPressed: messageController.text.isNotEmpty || image == true
                ? () {
                    ChatCubit.get(context).sendMessage(
                      message: messageController.text.isNotEmpty
                          ? messageController.text
                          : null,
                      receiverId: receiver.uId,
                      dateTime: DateTime.now().toString(),
                    );
                    messageController.text = "";
                    if (image == true) {
                      Navigator.pop(context);
                    }
                  }
                : () {},
          ),
        );
      }, listener: (context, state) {
        if (state is GalleryFileSelected) {
          buildPush(
              context,
              ShowImageSelected(
                selectedImage: ChatCubit.get(context).chatImage!,
                receiver: receiver,
              ));
        }
      }),
    );
  }
}

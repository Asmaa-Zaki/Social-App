import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/ChatCubit/chat_states.dart';
import 'package:social_app/ViewModels/Components/components.dart';

import '../../Models/UserModel/user_model.dart';
import '../../ViewModels/Bloc/ChatCubit/chat_cubit.dart';
import 'show_image_selected.dart';

class SendAction extends StatelessWidget {
  final UserModel receiver;
  final bool image;
  final TextEditingController messageController;

  const SendAction(this.receiver, this.image, this.messageController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            decoration: BoxDecoration(
                color: Colors.blueGrey[900],
                borderRadius:
                    const BorderRadiusDirectional.all(Radius.circular(20))),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      //   EmojiPicker();
                    },
                    icon: const Icon(Icons.emoji_emotions), color: Colors.white,),
                Expanded(
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration:  const InputDecoration(
                        hintStyle: TextStyle(
                            color: Colors.white
                        ),
                        hintText: "Type Message",
                        border: InputBorder.none),
                    controller: messageController,
                    keyboardType: TextInputType.multiline,
                    onChanged: (val) {
                      ChatCubit.get(context).changeMessageIcon();
                    },
                  ),
                ),
                if (image != true)
                  IconButton(
                    icon: const Icon(Icons.image, color: Colors.white,),
                    onPressed: () {
                      ChatCubit.get(context).openGallery();
                    },
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 7,),
        Expanded(
          flex: 2,
          child: BlocConsumer<ChatCubit, ChatStates>(builder: (context, state) {
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
                onPressed: messageController.text.isNotEmpty || image == true? () {
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
                }: (){},
              ),
            );
          }, listener: (context, state) {
            if (state is GalleryFileSelected) {
              buildPush(
                  context,
                  ShowImageSelected(
                    selectedImage: ChatCubit.get(context).chatImage!,
                    receiver: receiver,
                    messageController: messageController,
                  ));
            }
          }),
        ),
      ],
    );
  }
}

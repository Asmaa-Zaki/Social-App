import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_app/ViewModels/Bloc/ChatCubit/chat_cubit.dart';
import 'package:social_app/Widgets/ChatDetailsScreen/send_action.dart';

import '../../../Models/UserModel/user_model.dart';

class ShowImageSelected extends StatelessWidget {
  final File selectedImage;
  final UserModel receiver;

  const ShowImageSelected(
      {Key? key, required this.selectedImage, required this.receiver})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ChatCubit.get(context).chatImage = null;
        ChatCubit.get(context).messageController.clear();
        ChatCubit.get(context).changeMessageIcon();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            IconButton(
                onPressed: () {
                  ChatCubit.get(context).chatImage = null;
                  ChatCubit.get(context).messageController.clear();
                  ChatCubit.get(context).changeMessageIcon();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Image(image: FileImage(selectedImage)),
              ),
            ),
            SendAction(receiver, true),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

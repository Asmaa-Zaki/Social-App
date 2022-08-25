import 'package:flutter/material.dart';

import '../../ViewModels/Bloc/PostCubit/post_cubit.dart';

class CreatePostButton extends StatelessWidget {
  final TextEditingController textController;
  final DateTime now;

  const CreatePostButton(
      {Key? key, required this.textController, required this.now})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: () {
          if (PostCubit.get(context).postImage == null) {
            PostCubit.get(context).createPost(
                text: textController.text,
                dateTime: now.toString(),
                context: context);
          } else {
            {
              PostCubit.get(context).createPostWithImage(
                  text: textController.text,
                  dateTime: now.toString(),
                  context: context);
            }
          }
        },
        child: const Text(
          "Add",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ));
  }
}

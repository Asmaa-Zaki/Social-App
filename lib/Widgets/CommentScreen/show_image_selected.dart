import 'package:flutter/material.dart';
import 'package:flutter_persistent_keyboard_height/flutter_persistent_keyboard_height.dart';
import 'package:social_app/ViewModels/Bloc/CommentCubit/comment_cubit.dart';
import 'package:social_app/Widgets/CommentScreen/send_comment.dart';

class ShowImageSelected extends StatelessWidget {
  const ShowImageSelected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CommentCubit.get(context).changeKeyboardState(false);
    return WillPopScope(
      onWillPop: () async {
        CommentCubit.get(context).changeMessageIcon();
        CommentCubit.get(context).commentImagePath = null;
        CommentCubit.get(context).commentController.clear();
        return true;
      },
      child: PersistentKeyboardHeightProvider(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            actions: [
              IconButton(
                  onPressed: () {
                    CommentCubit.get(context).commentController.clear();
                    CommentCubit.get(context).commentImagePath = null;
                    CommentCubit.get(context).changeMessageIcon();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Center(
                  child: Image(
                      image: FileImage(
                          CommentCubit.get(context).commentImagePath!)),
                ),
              ),
              const SendComment(hideImage: true, hideEmoji: true),
            ],
          ),
        ),
      ),
    );
  }
}

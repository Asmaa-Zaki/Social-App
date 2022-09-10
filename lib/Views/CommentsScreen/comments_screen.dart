import 'package:flutter/material.dart';
import 'package:flutter_persistent_keyboard_height/flutter_persistent_keyboard_height.dart';
import 'package:social_app/ViewModels/Bloc/CommentCubit/comment_cubit.dart';
import 'package:social_app/ViewModels/Constants/constants.dart';
import 'package:social_app/Widgets/CommentScreen/post_comments.dart';
import 'package:social_app/Widgets/CommentScreen/send_comment.dart';
import 'package:social_app/Widgets/CommentScreen/show_emoji_picker.dart';

import '../../Widgets/CommentScreen/post_likes.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      child: SizedBox(
        height: heightScreen! - statusBarHeight!,
        child: PersistentKeyboardHeightProvider(
          child: WillPopScope(
            onWillPop: () async {
              CommentCubit.get(context).changeEmojiState(true);
              return true;
            },
            child: Scaffold(
              key: CommentCubit.get(context).scaffoldKey,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  PostLikes(),
                  PostComments(),
                  SendComment(
                    hideImage: false,
                    hideEmoji: false,
                  ),
                  ShowCommentEmojiPicker(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

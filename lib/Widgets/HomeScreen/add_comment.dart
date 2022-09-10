import 'package:flutter/material.dart';
import 'package:social_app/Models/PostModel/post_model.dart';

import '../../ViewModels/Bloc/CommentCubit/comment_cubit.dart';
import 'comment_bottom_sheet.dart';

class AddComment extends StatelessWidget {
  final PostModel post;

  const AddComment({Key? key, required this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CommentCubit.get(context).currentPost = post;
        CommentCubit.get(context).changeKeyboardState(true);
        commentBottomSheet(context);
      },
      child: Row(
        children: const [
          Icon(
            Icons.mode_comment_outlined,
            size: 17,
          ),
          Text(" Comment")
        ],
      ),
    );
  }
}

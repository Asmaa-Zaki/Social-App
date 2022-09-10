import 'package:flutter/material.dart';

import '../../Models/PostModel/post_model.dart';
import '../../ViewModels/Bloc/CommentCubit/comment_cubit.dart';
import '../HomeScreen/add_like.dart';
import '../HomeScreen/show_likes.dart';

class PostLikes extends StatelessWidget {
  const PostLikes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostModel post = CommentCubit.get(context).currentPost;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 5),
            child: AddLike(post: post),
          ),
          ShowLikes(
            post: post,
          )
        ],
      ),
    );
  }
}

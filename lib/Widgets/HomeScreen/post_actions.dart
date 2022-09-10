import 'package:flutter/material.dart';
import 'package:social_app/Models/PostModel/post_model.dart';
import 'package:social_app/Widgets/HomeScreen/add_like.dart';

import 'add_comment.dart';

class PostActions extends StatelessWidget {
  final PostModel post;

  const PostActions({Key? key, required this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AddLike(
              post: post,
            ),
            AddComment(post: post)
          ],
        ),
      ),
    );
  }
}

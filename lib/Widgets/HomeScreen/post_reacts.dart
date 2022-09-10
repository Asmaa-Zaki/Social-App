import 'package:flutter/material.dart';
import 'package:social_app/Models/PostModel/post_model.dart';
import 'package:social_app/Widgets/HomeScreen/show_likes.dart';

import 'show_comments.dart';

class PostReactions extends StatelessWidget {
  final PostModel post;

  const PostReactions({Key? key, required this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [ShowLikes(post: post), ShowComments(post: post)],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../ViewModels/Bloc/PostCubit/post_cubit.dart';

class PostActions extends StatelessWidget {
  final int index;

  const PostActions({Key? key, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              PostCubit.get(context)
                  .likePost(PostCubit.get(context).postsId[index]);
            },
            child: Row(
              children: [
                const Icon(
                  Icons.favorite_outline,
                ),
                Text(PostCubit.get(context).likes[index].toString() + " Likes")
              ],
            ),
          ),
          Row(
            children: const [
              Icon(
                Icons.mode_comment_outlined,
              ),
              Text("0 Comments")
            ],
          )
        ],
      ),
    );
  }
}

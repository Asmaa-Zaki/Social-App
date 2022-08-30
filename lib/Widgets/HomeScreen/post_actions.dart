import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Models/PostModel/post_model.dart';
import 'package:social_app/ViewModels/Bloc/PostCubit/post_states.dart';

import '../../ViewModels/Bloc/PostCubit/post_cubit.dart';
import '../../ViewModels/Constants/constants.dart';

class PostActions extends StatelessWidget {
  final PostModel post;

  const PostActions({Key? key, required this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(onTap: () {
              PostCubit.get(context).likePost(post.postId);
            }, child: BlocBuilder<PostCubit, PostAppStates>(
                builder: (context, state) {
              List<String>? likes = PostCubit.get(context).likes[post.postId];
              bool ownerLikeThePost = false;
              likes?.forEach((element) {
                if (element == uId) {
                  ownerLikeThePost = true;
                }
              });

              return Row(
                children: [
                  Icon(
                    ownerLikeThePost
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: Colors.red,
                    size: 18,
                  ),
                  const Text(" Love")
                ],
              );
            })),
            Row(
              children: const [
                Icon(
                  Icons.mode_comment_outlined,
                  size: 17,
                ),
                Text(" Comment")
              ],
            )
          ],
        ),
      ),
    );
  }
}

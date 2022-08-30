import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Models/PostModel/post_model.dart';
import 'package:social_app/ViewModels/Bloc/PostCubit/post_states.dart';

import '../../ViewModels/Bloc/PostCubit/post_cubit.dart';

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
          children: [
            InkWell(
                onTap: () {},
                child: BlocBuilder<PostCubit, PostAppStates>(
                    builder: (context, state) {
                  List<String>? likes =
                      PostCubit.get(context).likes[post.postId];
                  String? likesCount = likes?.length.toString();

                  return Row(
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 18,
                      ),
                      Text(likesCount ?? " 0 ")
                    ],
                  );
                })),
            const Text(" 0 Comments")
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Models/PostModel/post_model.dart';
import '../../ViewModels/Bloc/PostCubit/post_cubit.dart';
import '../../ViewModels/Bloc/PostCubit/post_states.dart';
import '../../ViewModels/Constants/constants.dart';

class AddLike extends StatelessWidget {
  final PostModel post;

  const AddLike({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () {
      PostCubit.get(context).likePost(post.postId);
    }, child: BlocBuilder<PostCubit, PostAppStates>(builder: (context, state) {
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
            ownerLikeThePost ? Icons.favorite : Icons.favorite_border_outlined,
            color: Colors.red,
            size: 18,
          ),
          const Text(" Love")
        ],
      );
    }));
  }
}

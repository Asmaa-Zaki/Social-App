import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Models/CommentModel/comment_model.dart';
import '../../Models/PostModel/post_model.dart';
import '../../ViewModels/Bloc/CommentCubit/comment_cubit.dart';
import '../../ViewModels/Bloc/CommentCubit/comment_states.dart';
import 'build_comment.dart';

class PostComments extends StatelessWidget {
  const PostComments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostModel post = CommentCubit.get(context).currentPost;
    CommentCubit.get(context).getComments(postId: post.postId);
    return Expanded(
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: .85,
        child:
            BlocBuilder<CommentCubit, CommentStates>(builder: (context, state) {
          List<CommentModel> comments = CommentCubit.get(context).comments;
          return ListView.builder(
            itemBuilder: (context, index) {
              return BuildComment(
                commentModel: comments[index],
              );
            },
            itemCount: comments.length,
          );
        }),
      ),
    );
  }
}

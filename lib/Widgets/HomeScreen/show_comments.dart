import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Models/PostModel/post_model.dart';
import 'package:social_app/ViewModels/Bloc/CommentCubit/comment_cubit.dart';
import 'package:social_app/ViewModels/Bloc/CommentCubit/comment_states.dart';
import 'package:social_app/ViewModels/Bloc/PostCubit/post_cubit.dart';

import 'comment_bottom_sheet.dart';

class ShowComments extends StatelessWidget {
  final PostModel post;

  const ShowComments({Key? key, required this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentCubit, CommentStates>(builder: (context, state) {
      Map<String, int> comments = PostCubit.get(context).comments;

      return InkWell(
          onTap: () {
            CommentCubit.get(context).currentPost = post;
            CommentCubit.get(context).changeKeyboardState(false);
            commentBottomSheet(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(comments[post.postId].toString() + " Comments"))
              ],
            ),
          ));
    });
  }
}

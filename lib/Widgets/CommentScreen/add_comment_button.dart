import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/CommentCubit/comment_cubit.dart';
import 'package:social_app/ViewModels/Bloc/CommentCubit/comment_states.dart';

class AddCommentButton extends StatelessWidget {
  const AddCommentButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentCubit, CommentStates>(
      builder: (context, state) {
        TextEditingController commentController =
            CommentCubit.get(context).commentController;

        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blueGrey[900],
          ),
          child: IconButton(
            disabledColor: Colors.grey.shade500,
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.send),
            onPressed: commentController.text.isNotEmpty ||
                    CommentCubit.get(context).commentImagePath != null
                ? () {
                    CommentCubit.get(context).postComment();
                    CommentCubit.get(context).changeKeyboardState(false);
                    if (CommentCubit.get(context).commentImagePath != null) {
                      CommentCubit.get(context).commentImagePath = null;
                      Navigator.pop(context);
                    }
                  }
                : null,
          ),
        );
      },
    );
  }
}

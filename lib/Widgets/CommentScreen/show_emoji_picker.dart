import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_persistent_keyboard_height/flutter_persistent_keyboard_height.dart';
import 'package:social_app/ViewModels/Bloc/CommentCubit/comment_cubit.dart';
import 'package:social_app/ViewModels/Bloc/CommentCubit/comment_states.dart';

class ShowCommentEmojiPicker extends StatelessWidget {
  const ShowCommentEmojiPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentCubit, CommentStates>(
      builder: (context, state) {
        return Offstage(
          offstage: CommentCubit.get(context).emojiHide,
          child: SizedBox(
            height: PersistentKeyboardHeight.of(context).keyboardHeight,
          ),
        );
      },
    );
  }
}

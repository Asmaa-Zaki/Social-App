import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Components/components.dart';

import '../../ViewModels/Bloc/PostCubit/post_cubit.dart';
import '../../ViewModels/Bloc/PostCubit/post_states.dart';

class CreatePostButton extends StatelessWidget {
  final TextEditingController textController;

  const CreatePostButton({Key? key, required this.textController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostStates>(builder: (context, state) {
      return MaterialButton(
        textColor: Colors.white,
        disabledTextColor: Colors.grey[700],
        onPressed: (PostCubit.get(context).postAssetPath != null ||
                textController.text.isNotEmpty)
            ? () {
                if (PostCubit.get(context).postAssetPath == null) {
                  PostCubit.get(context).createPost(
                      text: textController.text,
                      dateTime: DateTime.now().toString(),
                      context: context);
                } else {
                  {
                    PostCubit.get(context).createPostWithAsset(
                        text: textController.text.isEmpty
                            ? null
                            : textController.text,
                        dateTime: DateTime.now().toString(),
                        context: context);
                  }
                }
              }
            : null,
        child: state is! PostCreateLoadingState
            ? const Text(
                "Add",
                style: TextStyle(fontSize: 17),
              )
            : const Padding(
                padding: EdgeInsets.all(13.0),
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              ),
      );
    }, listener: (context, state) {
      if (state is PostCreateSuccessState) {
        showSnackBar(context, "Your Post uploaded successfully");
        Navigator.pop(context);
      } else if (state is PostCreateErrorState) {
        showSnackBar(context, "Error uploading your post");
      }
    });
  }
}

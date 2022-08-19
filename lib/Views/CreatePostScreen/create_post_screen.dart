import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Components/components.dart';
import 'package:social_app/Widgets/CreatePostScreen/post_add_photo.dart';
import 'package:social_app/Widgets/CreatePostScreen/post_body.dart';
import 'package:social_app/Widgets/CreatePostScreen/post_user_data.dart';

import '../../ViewModels/Bloc/PostCubit/post_cubit.dart';
import '../../ViewModels/Bloc/PostCubit/post_states.dart';
import '../../Widgets/CreatePostScreen/create_post_button.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final now = DateTime.now();
    return BlocConsumer<PostCubit, PostAppStates>(builder: (context, state) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Create Post"),
          actions: [
            if (state is! PostUploadImageLoadingState ||
                state is! PostCreateLoadingState)
              CreatePostButton(
                textController: textController,
                now: now,
              )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const PostUserData(),
              const SizedBox(
                height: 5,
              ),
              PostBody(textController: textController),
              const Spacer(),
              const PostAddPhoto(),
            ],
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is PostCreateSuccessState) {
        showSnackBar(context, "Your Post uploaded successfully");
        Navigator.pop(context);
      }
    });
  }
}

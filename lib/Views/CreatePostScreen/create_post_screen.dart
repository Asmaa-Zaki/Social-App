import 'package:flutter/material.dart';
import 'package:social_app/ViewModels/Bloc/PostCubit/post_cubit.dart';
import 'package:social_app/Widgets/CreatePostScreen/post_add_asset.dart';
import 'package:social_app/Widgets/CreatePostScreen/post_body.dart';
import 'package:social_app/Widgets/CreatePostScreen/post_user_data.dart';

import '../../Widgets/CreatePostScreen/create_post_button.dart';
import '../../Widgets/CreatePostScreen/discard_changes_dialog.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    return WillPopScope(
      onWillPop: () async {
        if (PostCubit.get(context).postAssetPath != null ||
            textController.text.isNotEmpty) {
          discardChangesDialog(context, textController);
        }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Create Post"),
          actions: [
            CreatePostButton(
              textController: textController,
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
              const PostAddAsset(),
            ],
          ),
        ),
      ),
    );
  }
}

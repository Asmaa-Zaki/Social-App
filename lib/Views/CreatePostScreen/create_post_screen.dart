import 'package:flutter/material.dart';
import 'package:social_app/Widgets/CreatePostScreen/post_add_asset.dart';
import 'package:social_app/Widgets/CreatePostScreen/post_body.dart';
import 'package:social_app/Widgets/CreatePostScreen/post_user_data.dart';

import '../../Widgets/CreatePostScreen/create_post_button.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final now = DateTime.now();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Create Post"),
        actions: [
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
            const PostAddAsset(),
          ],
        ),
      ),
    );
  }
}

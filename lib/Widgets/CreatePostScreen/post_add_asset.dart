import 'package:flutter/material.dart';
import 'package:social_app/Widgets/CreatePostScreen/add_post_image.dart';
import 'package:social_app/Widgets/CreatePostScreen/add_post_video.dart';
import 'package:social_app/Widgets/CreatePostScreen/show_selected_asset.dart';

class PostAddAsset extends StatelessWidget {
  const PostAddAsset({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ShowSelectedAsset(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            AddPostImage(),
            AddPostVideo(),
          ],
        )
      ],
    );
  }
}

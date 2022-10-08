import 'package:flutter/material.dart';
import 'package:social_app/Models/PostModel/post_model.dart';
import 'package:social_app/ViewModels/Bloc/PostCubit/post_cubit.dart';

import '../../Widgets/SharedWidgets/PostCard/post_card.dart';

class ShowPostScreen extends StatelessWidget {
  final String postId;

  const ShowPostScreen({Key? key, required this.postId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    PostModel post = PostCubit.get(context).getPost(postId);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Post Updates"),
        ),
        body: PostCard(postModel: post),
      ),
    );
  }
}

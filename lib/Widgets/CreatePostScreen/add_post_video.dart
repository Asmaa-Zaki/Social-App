import 'package:flutter/material.dart';

import '../../ViewModels/Bloc/PostCubit/post_cubit.dart';

class AddPostVideo extends StatelessWidget {
  const AddPostVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostCubit postCubit = PostCubit.get(context);

    return MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          postCubit.getPostVideo();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.video_call,
              size: 16,
              color: Theme.of(context).iconTheme.color,
            ),
            Text(
              " Add Video",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyText1?.color),
            )
          ],
        ));
  }
}

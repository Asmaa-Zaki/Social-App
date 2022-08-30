import 'package:flutter/material.dart';

import '../../ViewModels/Bloc/PostCubit/post_cubit.dart';

class AddPostImage extends StatelessWidget {
  const AddPostImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostCubit postCubit = PostCubit.get(context);
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        postCubit.getPostImage();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_photo_alternate_outlined,
            size: 16,
            color: Theme.of(context).iconTheme.color,
          ),
          Text(
            " Add Photo",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyText1?.color),
          )
        ],
      ),
    );
  }
}

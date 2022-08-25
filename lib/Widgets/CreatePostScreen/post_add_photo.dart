import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/PostCubit/post_states.dart';

import '../../ViewModels/Bloc/PostCubit/post_cubit.dart';

class PostAddPhoto extends StatelessWidget {
  const PostAddPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostAppStates>(
      builder: (context, state) {
        return Column(
          children: [
            if (PostCubit.get(context).postImage != null)
              SizedBox(
                height: 200,
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Image(
                      image: FileImage(PostCubit.get(context).postImage!),
                      fit: BoxFit.cover,
                    ),
                    IconButton(
                        onPressed: () {
                          PostCubit.get(context).removePostImage();
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                PostCubit.get(context).getPostImage();
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
            ),
          ],
        );
      },
      listener: (context, state) {},
    );
  }
}

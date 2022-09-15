import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/PostCubit/post_states.dart';

import '../../ViewModels/Bloc/PostCubit/post_cubit.dart';
import '../HomeScreen/show_post_video.dart';

class ShowSelectedAsset extends StatelessWidget {
  const ShowSelectedAsset({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostStates>(builder: (context, state) {
      PostCubit postCubit = PostCubit.get(context);
      if (postCubit.postAssetPath != null) {
        return SizedBox(
          height: 200,
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              if (postCubit.assetType == "image")
                Image(
                  image: FileImage(postCubit.postAssetPath!),
                  fit: BoxFit.cover,
                ),
              if (postCubit.assetType == "video")
                DisplayVideo(postCubit.postAssetPath!),
              IconButton(
                  onPressed: () {
                    postCubit.removePostAsset();
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.red,
                  ))
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }
}

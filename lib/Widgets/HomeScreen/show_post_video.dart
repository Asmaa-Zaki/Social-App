import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/VideoCubit/video_cubit.dart';
import 'package:social_app/ViewModels/Bloc/VideoCubit/video_states.dart';

class DisplayVideo extends StatelessWidget {
  final dynamic videoPath;
  const DisplayVideo(this.videoPath, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VideoCubit>(
      create: (context) {
        if (videoPath.runtimeType == String) {
          return VideoCubit()..videoNetworkInit(videoPath);
        } else {
          return VideoCubit()..videoFileInit(videoPath);
        }
      },
      child: Scaffold(
        body: BlocBuilder<VideoCubit, VideoStates>(builder: (context, state) {
          var videoCubit = VideoCubit.get(context);
          var _controller = videoCubit.controller;
          return Center(
            child: _controller.value.isInitialized
                ? Chewie(
                    controller: VideoCubit.get(context).chewieController,
                  )
                : Container(),
          );
        }),
      ),
    );
  }
}

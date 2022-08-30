import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/VideoCubit/video_states.dart';
import 'package:video_player/video_player.dart';

class VideoCubit extends Cubit<VideoStates> {
  VideoCubit() : super(VideoInitState());

  static VideoCubit get(BuildContext context) => BlocProvider.of(context);

  late VideoPlayerController controller;
  late ChewieController chewieController;

  void videoNetworkInit(String url) {
    emit(VideoInitializedLoading());
    controller = VideoPlayerController.network(url)
      ..initialize().then((value) {
        chewieController = ChewieController(
          allowFullScreen: false,
          videoPlayerController: controller,
        );
        emit(VideoInitializedSuccess());
      }).catchError((err) {
        emit(VideoInitializedError());
      });
  }

  void videoFileInit(File url) {
    emit(VideoInitializedLoading());
    controller = VideoPlayerController.file(url)
      ..initialize().then((value) {
        chewieController = ChewieController(
          allowFullScreen: false,
          videoPlayerController: controller,
        );
        emit(VideoInitializedSuccess());
      }).catchError((err) {
        emit(VideoInitializedError());
      });
  }
}

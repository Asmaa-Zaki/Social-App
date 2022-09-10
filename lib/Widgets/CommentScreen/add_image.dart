import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/CommentCubit/comment_cubit.dart';
import 'package:social_app/ViewModels/Bloc/CommentCubit/comment_states.dart';
import 'package:social_app/ViewModels/Components/components.dart';
import 'package:social_app/Widgets/CommentScreen/show_image_selected.dart';

class AddImage extends StatelessWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentCubit, CommentStates>(builder: (context, state) {
      if (CommentCubit.get(context).commentController.text.isEmpty) {
        return IconButton(
          icon: const Icon(
            Icons.image,
            color: Colors.white,
          ),
          onPressed: () {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
            CommentCubit.get(context).changeEmojiState(true);
            CommentCubit.get(context).openGallery();
          },
        );
      } else {
        return const Text("");
      }
    }, listener: (context, state) {
      if (state is GalleryFileSelected) {
        buildPush(context, const ShowImageSelected());
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:social_app/ViewModels/Bloc/PostCubit/post_cubit.dart';

void discardChangesDialog(
    BuildContext context, TextEditingController textController) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Post Action"),
            content: const Text("Discard changes?"),
            actions: [
              TextButton(
                  onPressed: () {
                    PostCubit.get(context).removePostAsset();
                    textController.clear();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No")),
            ],
          ));
}

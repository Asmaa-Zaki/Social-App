import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:social_app/ViewModels/Bloc/PostCubit/post_cubit.dart';
import 'package:social_app/ViewModels/Bloc/PostCubit/post_states.dart';

class PostBody extends StatelessWidget {
  final TextEditingController textController;

  const PostBody({Key? key, required this.textController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool rtl = false;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<PostCubit, PostStates>(
          builder: (context, state) => TextField(
            textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
            controller: textController,
            decoration: const InputDecoration(
                hintText: "What is in your Mind!",
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none),
            maxLines: 10,
            onChanged: (value) {
              rtl = intl.Bidi.detectRtlDirectionality(value);
              PostCubit.get(context).postBodyChanged();
            },
          ),
        ),
      ],
    );
  }
}

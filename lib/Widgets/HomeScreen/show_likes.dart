import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/PostCubit/post_states.dart';

import '../../Models/PostModel/post_model.dart';
import '../../ViewModels/Bloc/PostCubit/post_cubit.dart';
import '../../ViewModels/Bloc/UserCubit/user_cubit.dart';
import '../../ViewModels/Components/Components.dart';
import '../../Views/UsersScreen/users_screen.dart';

class ShowLikes extends StatelessWidget {
  final PostModel post;

  const ShowLikes({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostAppStates>(builder: (context, state) {
      List<String>? likes = PostCubit.get(context).likes[post.postId];
      String? likesCount = likes?.length.toString();

      return InkWell(
          onTap: () {
            UserCubit.get(context).getPostLikesUsers(likes ?? []);
            buildPush(
                context,
                UsersScreen(
                  users: UserCubit.get(context).likesUsers,
                ));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 18,
                ),
                Container(
                    padding: const EdgeInsets.only(left: 5),
                    width: 30,
                    child: Text(likesCount ?? " 0 "))
              ],
            ),
          ));
    });
  }
}

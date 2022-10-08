import 'package:flutter/material.dart';
import 'package:social_app/Models/PostModel/post_model.dart';

import '../../../Models/UserModel/user_model.dart';
import '../../../ViewModels/Bloc/UserCubit/user_cubit.dart';
import '../../HomeScreen/post_actions.dart';
import '../../HomeScreen/post_data.dart';
import '../../HomeScreen/post_reacts.dart';
import '../../HomeScreen/post_user_data.dart';

class PostCard extends StatelessWidget {
  final PostModel postModel;

  const PostCard({Key? key, required this.postModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    UserModel? user = UserCubit.get(context).getUserWithId(postModel.uId);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 3),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserData(user: user!, dateTime: postModel.dateTime),
          PostData(
            postModel: postModel,
          ),
          const SizedBox(
            height: 7,
          ),
          PostReactions(post: postModel),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 1,
            color:
                Theme.of(context).textTheme.subtitle1?.color?.withOpacity(.2),
          ),
          PostActions(post: postModel)
        ],
      ),
    );
  }
}

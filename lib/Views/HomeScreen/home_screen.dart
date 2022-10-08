import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/ThemeCubit/theme_cubit.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_cubit.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_states.dart';
import 'package:social_app/Widgets/SharedWidgets/PostCard/post_card.dart';

import '../../ViewModels/Bloc/FriendCubit/friend_cubit.dart';
import '../../ViewModels/Bloc/FriendCubit/friend_states.dart';
import '../../ViewModels/Bloc/PostCubit/post_cubit.dart';
import '../../ViewModels/Bloc/PostCubit/post_states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendCubit, FriendStates>(
      builder: (context, state) =>
          BlocBuilder<UserCubit, UserStates>(builder: (context, state) {
        return BlocBuilder<PostCubit, PostStates>(builder: (context, state) {
          var list = PostCubit.get(context).postsList.reversed.toList();
          return ConditionalBuilder(
            condition: state is! PostsGetLoadingState,
            builder: (context) => Container(
              color: ThemeCubit.get(context).darkTheme
                  ? Colors.black38
                  : Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: RefreshIndicator(
                  onRefresh: () {
                    PostCubit.get(context).getPosts(true);
                    return Future.delayed(
                      const Duration(seconds: 3),
                    );
                  },
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return PostCard(postModel: list[index]);
                    },
                    itemCount: list.length,
                  )),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        });
      }),
    );
  }
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_cubit.dart';
import 'package:social_app/Widgets/HomeScreen/post_actions.dart';
import 'package:social_app/Widgets/HomeScreen/post_data.dart';
import 'package:social_app/Widgets/HomeScreen/post_user_data.dart';

import '../../Models/UserModel/user_model.dart';
import '../../ViewModels/Bloc/PostCubit/post_cubit.dart';
import '../../ViewModels/Bloc/PostCubit/post_states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostAppStates>(
        builder: (context, state) {
          var list = PostCubit.get(context).postsList.reversed.toList();
          return ConditionalBuilder(
            condition: state is! PostsGetLoadingState,
            builder: (context) => ListView.builder(
              itemBuilder: (context, index) {
                UserModel? user= UserCubit.get(context).getPostOwner(list[index].uId!);
                return Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserData(user: user!, dateTime: list[index].dateTime!),
                        Container(
                          height: .5,
                          color: Colors.grey[300],
                        ),
                        PostData(list: list, index: index),
                        const SizedBox(
                          height: 7,
                        ),
                        PostActions(index: index)
                      ],
                    ),
                  ),
                );
              },
              itemCount: list.length,
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        },
        listener: (context, state) {});
  }
}
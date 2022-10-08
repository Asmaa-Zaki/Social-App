import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Models/UserModel/user_model.dart';
import 'package:social_app/ViewModels/Bloc/FriendCubit/friend_cubit.dart';
import 'package:social_app/ViewModels/Bloc/FriendCubit/friend_states.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_states.dart';

import '../../ViewModels/Bloc/UserCubit/user_cubit.dart';
import '../../ViewModels/Constants/constants.dart';

class AppUsers extends StatelessWidget {
  final List<UserModel>? usersList;
  final bool showLikes;
  const AppUsers({Key? key, this.usersList, required this.showLikes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FriendCubit.get(context).getAllFriendsDetails(false, loading: true);

    return BlocConsumer<FriendCubit, FriendStates>(
        builder: (context, friendState) {
      FriendCubit _friendCubit = FriendCubit.get(context);
      return BlocBuilder<UserCubit, UserStates>(
        builder: (context, state) {
          List<UserModel> users = [];
          if (!showLikes) {
            users = UserCubit.get(context).usersWithoutFriendsList;
          } else {
            users = usersList!;
          }
          return ConditionalBuilder(
              condition: state is! GetFriendsLoading,
              builder: (context) => ListView.builder(
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(users[index].image),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                users[index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        if (_friendCubit.requests[users[index].uId] == null &&
                            users[index].uId != uId)
                          IconButton(
                              onPressed: () {
                                _friendCubit.addFriend(
                                    users[index].uId, context);
                              },
                              icon: const Icon(Icons.person_add_alt_1)),
                        if (_friendCubit.requests[users[index].uId] == "Sent")
                          IconButton(
                              onPressed: () {
                                _friendCubit.removeFriend(
                                    users[index].uId, false, false);
                              },
                              icon: const Icon(Icons.person_remove)),
                        if (_friendCubit.requests[users[index].uId] ==
                            "Received")
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    _friendCubit.acceptFriend(
                                        users[index].uId, context);
                                  },
                                  icon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    _friendCubit.removeFriend(
                                        users[index].uId, true, true);
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                      ],
                    );
                  },
                  itemCount: users.length),
              fallback: (context) => const CircularProgressIndicator());
        },
      );
    }, listener: (context, state) {
      if (state is GetFriendAcceptedSuccess || state is AcceptFriendSuccess) {
        if (state is AcceptFriendSuccess) {
          FriendCubit.get(context).acceptedFriends.add(state.acceptedFriend);
        }
        UserCubit.get(context)
            .usersWithoutFriends(FriendCubit.get(context).acceptedFriends);
      }
    });
  }
}

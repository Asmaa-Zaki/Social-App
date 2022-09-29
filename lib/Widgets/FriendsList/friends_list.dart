import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_persistent_keyboard_height/flutter_persistent_keyboard_height.dart';
import 'package:social_app/Models/UserModel/user_model.dart';
import 'package:social_app/ViewModels/Bloc/FriendBloc/friend_cubit.dart';
import 'package:social_app/ViewModels/Bloc/FriendBloc/friend_states.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_states.dart';
import 'package:social_app/ViewModels/Components/components.dart';

import '../../ViewModels/Bloc/UserCubit/user_cubit.dart';
import '../../Views/ChatsDetails/chats_details.dart';

class FriendsUsers extends StatelessWidget {
  const FriendsUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FriendCubit.get(context).getAllFriendsDetails(false);
    return BlocConsumer<FriendCubit, FriendStates>(
        builder: (context, state) =>
            BlocBuilder<UserCubit, UserStates>(builder: (context, state) {
              List<UserModel> users = UserCubit.get(context).friendsList;
              return ListView.builder(
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: InkWell(
                            onTap: () {
                              buildPush(
                                  context,
                                  PersistentKeyboardHeightProvider(
                                      child: ChatsDetails(users[index])));
                            },
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
                        ),
                      ],
                    );
                  },
                  itemCount: users.length);
            }),
        listener: (context, state) {
          if (state is GetFriendAcceptedSuccess) {
            UserCubit.get(context)
                .getFriendsUsers(FriendCubit.get(context).acceptedFriends);
          }
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_persistent_keyboard_height/flutter_persistent_keyboard_height.dart';
import 'package:social_app/Models/UserModel/user_model.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_states.dart';
import 'package:social_app/ViewModels/Components/components.dart';

import '../../ViewModels/Bloc/UserCubit/user_cubit.dart';
import '../../Views/ChatsDetails/chats_details.dart';

class AppUsers extends StatelessWidget {
  final List<UserModel> users;
  final bool startChat;
  const AppUsers({Key? key, required this.users, required this.startChat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserStates>(
      builder: (context, state) {
        return ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  onTap: startChat
                      ? () {
                          buildPush(
                              context,
                              PersistentKeyboardHeightProvider(
                                  child: ChatsDetails(users[index])));
                        }
                      : null,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(users[index].image),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        users[index].name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: users.length);
      },
    );
  }
}

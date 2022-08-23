import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_persistent_keyboard_height/flutter_persistent_keyboard_height.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_states.dart';

import '../../ViewModels/Bloc/UserCubit/user_cubit.dart';
import '../../Views/ChatsDetails/chats_details.dart';

class AppUsers extends StatelessWidget {
  const AppUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
        builder: (context, state) {
          var users = UserCubit.get(context).users;
          return ListView.separated(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PersistentKeyboardHeightProvider(
                                      child: ChatsDetails(users[index]))));
                    },
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
              separatorBuilder: (context, index) {
                return Container(
                  height: 1,
                  color: Colors.grey,
                );
              },
              itemCount: users.length);
        },
        listener: (context, state) {});
  }
}

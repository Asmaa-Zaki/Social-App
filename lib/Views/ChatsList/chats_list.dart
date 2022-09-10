import 'package:flutter/material.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_cubit.dart';

import '../../Widgets/BuildUserList/build_user_list.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Friends"),
      ),
      body: Center(
        child: AppUsers(
          users: UserCubit.get(context).users,
          startChat: true,
        ),
      ),
    );
  }
}

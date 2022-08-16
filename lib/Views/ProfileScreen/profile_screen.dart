import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_states.dart';
import 'package:social_app/Widgets/ProfileScreen/profile_actions.dart';
import 'package:social_app/Widgets/ProfileScreen/user_data.dart';

import '../../ViewModels/Bloc/UserCubit/user_cubit.dart';
import '../../ViewModels/Components/Components.dart';
import '../SignInScreen/signIn_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(builder: (context, state) {
      var user = UserCubit.get(context).user;
      return Column(
        children: [
          ProfileUserData(user: user!),
          const ProfileActions(),
        ],
      );
    }, listener: (context, state) {
      if (state is UserLogoutSuccessState) {
        buildPushReplacement(context, const SignInScreen());
      }
    });
  }
}

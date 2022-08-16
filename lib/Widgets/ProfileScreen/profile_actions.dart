import 'package:flutter/material.dart';
import 'package:social_app/Widgets/ProfileScreen/log_out_action.dart';
import 'package:social_app/Widgets/ProfileScreen/profile_update_action.dart';

import 'dark_theme_action.dart';

class ProfileActions extends StatelessWidget {
  const ProfileActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ProfileUpdateAction(),
        DarkThemeAction(),
        LogOutAction()
      ],
    );
  }
}

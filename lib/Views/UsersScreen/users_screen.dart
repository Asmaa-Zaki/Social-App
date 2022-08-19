import 'package:flutter/material.dart';

import '../../Widgets/BuildUserList/build_user_list.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.all(8.0), child: AppUsers());
  }
}

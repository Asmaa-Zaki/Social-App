import 'package:flutter/material.dart';

import '../../ViewModels/Bloc/UserCubit/user_cubit.dart';

class PostUserData extends StatelessWidget {
  const PostUserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 23,
          backgroundImage: NetworkImage(UserCubit.get(context).user!.image),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          UserCubit.get(context).user!.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        )
      ],
    );
  }
}

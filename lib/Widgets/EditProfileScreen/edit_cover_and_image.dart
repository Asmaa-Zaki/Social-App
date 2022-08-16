import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Models/UserModel/user_model.dart';
import 'package:social_app/Widgets/EditProfileScreen/edit_image.dart';

import '../../ViewModels/Bloc/UserCubit/user_cubit.dart';
import '../../ViewModels/Bloc/UserCubit/user_states.dart';
import 'edit_cover.dart';

class EditCoverAndImage extends StatelessWidget {
  final BuildContext? context;
  const EditCoverAndImage(this.context, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel user = UserCubit.get(context).user!;

    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {},
      builder: (context, states) {
        return Scaffold(
            body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            EditCover(user: user,),
            EditImage(user: user,)
          ],
        ));
      },
    );
  }
}

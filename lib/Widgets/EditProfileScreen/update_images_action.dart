import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_cubit.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_states.dart';

class UpdateImagesButtons extends StatelessWidget {
  const UpdateImagesButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = UserCubit.get(context);
    return BlocBuilder<UserCubit, UserStates>(
      builder: (context, state) => Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          if (cubit.image != null || cubit.cover != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (cubit.image != null)
                  ElevatedButton(
                      onPressed: () {
                        UserCubit.get(context).updateProfileImage();
                      },
                      child: const Text("Update Image")),
                if (cubit.cover != null)
                  ElevatedButton(
                      onPressed: () {
                        UserCubit.get(context).updateProfileCover();
                      },
                      child: const Text("Update Cover"))
              ],
            ),
        ],
      ),
    );
  }
}

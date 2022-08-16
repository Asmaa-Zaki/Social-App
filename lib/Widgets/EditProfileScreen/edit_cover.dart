import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Models/UserModel/user_model.dart';

import '../../ViewModels/Bloc/UserCubit/user_cubit.dart';

class EditCover extends StatelessWidget {
  final UserModel user;

  const EditCover({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: 140,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              ConditionalBuilder(
                  condition: UserCubit.get(context).cover == null,
                  builder: (context) {
                    return Image.network(
                      user.cover,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    );
                  },
                  fallback: (context) {
                    return Image(
                      image: FileImage(UserCubit.get(context).cover!),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    );
                  }),
              CircleAvatar(
                  radius: 17,
                  backgroundColor: Colors.black,
                  child: IconButton(
                    onPressed: () {
                      UserCubit.get(context).getCover();
                    },
                    icon: const Icon(Icons.camera_alt),
                    color: Colors.white,
                    iconSize: 17,
                  )),
            ],
          ),
        ));
  }
}

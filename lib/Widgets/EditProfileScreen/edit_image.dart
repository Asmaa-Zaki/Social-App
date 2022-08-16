import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Models/UserModel/user_model.dart';

import '../../ViewModels/Bloc/UserCubit/user_cubit.dart';

class EditImage extends StatelessWidget {
  final UserModel user;

  const EditImage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CircleAvatar(
              radius: 41,
              backgroundColor:
              Theme.of(context).scaffoldBackgroundColor,
            ),
            CircleAvatar(
                radius: 50,
                child: Container(
                  height: 100,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration:
                  const BoxDecoration(shape: BoxShape.circle),
                  child: ConditionalBuilder(
                    builder: (BuildContext context) {
                      return Image(
                        image: NetworkImage(user.image),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      );
                    },
                    fallback: (BuildContext context) {
                      return Image(
                        image: FileImage(UserCubit.get(context).image!),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      );
                    },
                    condition: UserCubit.get(context).image == null,
                  ),
                )),
          ],
        ),
        CircleAvatar(
            radius: 17,
            backgroundColor: Colors.black,
            child: IconButton(
              onPressed: () {
                UserCubit.get(context).getImage();
              },
              icon: const Icon(Icons.camera_alt),
              color: Colors.white,
              iconSize: 17,
            )),
      ],
    );
  }
}

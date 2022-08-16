import 'package:flutter/material.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_cubit.dart';

class UpdateImagesButtons extends StatelessWidget {
  final UserCubit cubit;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController dioController;
  const UpdateImagesButtons(
      {Key? key,
      required this.cubit,
      required this.nameController,
      required this.phoneController,
      required this.dioController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      //  if (cubit.image != null || cubit.cover != null)
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
                      UserCubit.get(context).updateProfileImage(
                          nameController.text,
                          phoneController.text,
                          dioController.text);
                    },
                    child: const Text("Update Image")),
              if (cubit.cover != null)
                ElevatedButton(
                    onPressed: () {
                      UserCubit.get(context).updateProfileCover(
                          nameController.text,
                          phoneController.text,
                          dioController.text);
                    },
                    child: const Text("Update Cover"))
            ],
          ),
      ],
    );
  }
}

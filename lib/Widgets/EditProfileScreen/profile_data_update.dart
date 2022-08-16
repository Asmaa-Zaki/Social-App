import 'package:flutter/material.dart';

import '../../ViewModels/Bloc/UserCubit/user_cubit.dart';
import 'edit_user_form_data.dart';

class ProfileDataUpdate extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController dioController;

  const ProfileDataUpdate(
      {Key? key,
      required this.nameController,
      required this.phoneController,
      required this.dioController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: EditUserFormData(
                nameController, dioController, phoneController)),
          ElevatedButton(
              onPressed: () {
                UserCubit.get(context).updateProfileData(
                    name: nameController.text,
                    phone: phoneController.text,
                    dio: dioController.text);
              },
              child: const Text("Update"))
      ],
    );
  }
}

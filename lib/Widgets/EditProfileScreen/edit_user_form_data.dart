import 'package:flutter/material.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_cubit.dart';

import '../SharedWidgets/BuildTextForm/build_text_form_field.dart';

class EditUserFormData extends StatelessWidget {
  final GlobalKey formKey;
  const EditUserFormData({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserCubit userCubit = UserCubit.get(context);
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          BuildTextFormField(
            controller: UserCubit.get(context).nameController,
            label: "Name",
            preFix: Icons.person,
            onChange: (val) {
              userCubit.userNewData();
            },
            validate: (val) {
              if (val!.isEmpty) {
                return "Name is required";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          BuildTextFormField(
            controller: UserCubit.get(context).dioController,
            label: "Dio",
            preFix: Icons.info,
            onChange: (val) {
              userCubit.userNewData();
            },
            validate: (val) {
              if (val!.isEmpty) {
                return "Dio is required";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          BuildTextFormField(
            controller: UserCubit.get(context).phoneController,
            label: "Phone",
            preFix: Icons.phone,
            keyboard: TextInputType.phone,
            onChange: (val) {
              userCubit.userNewData();
            },
            validate: (val) {
              if (val!.isEmpty) {
                return "Phone is required";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

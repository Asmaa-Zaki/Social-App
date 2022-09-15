import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_states.dart';

import '../../ViewModels/Bloc/UserCubit/user_cubit.dart';
import 'edit_user_form_data.dart';

class ProfileDataUpdate extends StatelessWidget {
  const ProfileDataUpdate({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: EditUserFormData(
              formKey: formKey,
            )),
        BlocBuilder<UserCubit, UserStates>(builder: (context, state) {
          if (UserCubit.get(context).showUpdateButton) {
            return ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    UserCubit.get(context)
                        .updateProfileData(updateImage: false);
                  }
                },
                child: const Text("Update"));
          } else {
            return Container();
          }
        })
      ],
    );
  }
}

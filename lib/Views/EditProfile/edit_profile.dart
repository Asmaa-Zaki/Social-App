import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_cubit.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_states.dart';
import 'package:social_app/Widgets/EditProfileScreen/profile_data_update.dart';
import 'package:social_app/Widgets/EditProfileScreen/update_images_action.dart';

import '../../ViewModels/Components/components.dart';
import '../../Widgets/EditProfileScreen/edit_cover_and_image.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final dioController = TextEditingController();
    final phoneController = TextEditingController();

    return BlocConsumer<UserCubit, UserStates>(builder: (context, state) {
      var cubit = UserCubit.get(context);
      var user = UserCubit.get(context).user;
      nameController.text = user!.name;
      dioController.text = user.dio;
      phoneController.text = user.phone;
      return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              if (state is UserImageUploadLoadingState ||
                  state is UserCoverUploadLoadingState ||
                  state is UserProfileUpdateLoadingState)
                const LinearProgressIndicator(),
              SizedBox(height: 170, child: EditCoverAndImage(context)),
              UpdateImagesButtons(
                dioController: dioController,
                phoneController: phoneController,
                cubit: cubit,
                nameController: nameController,
              ),
              ProfileDataUpdate(
                  nameController: nameController,
                  phoneController: phoneController,
                  dioController: dioController)
            ],
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is UserImageUploadSuccessState ||
          state is UserCoverUploadSuccessState ||
          state is UserProfileUpdateSuccessState) {
        showSnackBar(context, "Profile updated successfully");
      }
    });
  }
}

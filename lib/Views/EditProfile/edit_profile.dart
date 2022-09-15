import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_cubit.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_states.dart';
import 'package:social_app/Widgets/EditProfileScreen/discard_changes_dialog.dart';
import 'package:social_app/Widgets/EditProfileScreen/profile_data_update.dart';
import 'package:social_app/Widgets/EditProfileScreen/update_images_action.dart';

import '../../ViewModels/Components/components.dart';
import '../../Widgets/EditProfileScreen/edit_cover_and_image.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(builder: (context, state) {
      return WillPopScope(
        onWillPop: () async {
          UserCubit userCubit = UserCubit.get(context);
          if (userCubit.showUpdateButton ||
              userCubit.image != null ||
              userCubit.cover != null) {
            discardChangesDialog(context);
          }
          return true;
        },
        child: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is UserImageUploadLoadingState ||
                      state is UserCoverUploadLoadingState ||
                      state is UserProfileUpdateLoadingState)
                    const LinearProgressIndicator(),
                  SizedBox(height: 185, child: EditCoverAndImage(context)),
                  const UpdateImagesButtons(),
                  const ProfileDataUpdate()
                ],
              ),
            ),
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

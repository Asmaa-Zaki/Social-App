import 'package:flutter/material.dart';

import '../../ViewModels/Bloc/UserCubit/user_cubit.dart';

void discardChangesDialog(BuildContext context) {
  UserCubit userCubit = UserCubit.get(context);
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Update profile"),
            content: const Text("Discard changes?"),
            actions: [
              TextButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    userCubit.userRemoveUpdates();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No")),
            ],
          ));
}

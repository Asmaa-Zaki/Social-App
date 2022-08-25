import 'package:flutter/material.dart';

import '../../ViewModels/Components/Components.dart';
import '../../Views/EditProfile/edit_profile.dart';

class ProfileUpdateAction extends StatelessWidget {
  const ProfileUpdateAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        buildPush(context, const EditProfile());
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: const [
            Icon(Icons.person),
            SizedBox(
              width: 10,
            ),
            Text(
              "Update Profile",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
            SizedBox(
              width: 5,
            )
          ],
        ),
      ),
    );
  }
}

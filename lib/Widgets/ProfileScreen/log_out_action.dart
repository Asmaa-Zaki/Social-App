import 'package:flutter/material.dart';

import '../../ViewModels/Bloc/UserCubit/user_cubit.dart';

class LogOutAction extends StatelessWidget {
  const LogOutAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        UserCubit.get(context).logOut();
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: const [
            Icon(Icons.logout),
            SizedBox(
              width: 10,
            ),
            Text(
              "LogOut",
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

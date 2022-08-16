import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ViewModels/Bloc/UserCubit/user_cubit.dart';
import '../../ViewModels/Bloc/UserCubit/user_states.dart';
import '../../ViewModels/Components/Components.dart';
import '../../Views/LayoutScreen/layout_screen.dart';
import '../../Views/SignUpScreen/signUp_screen.dart';

class SignInActions extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const SignInActions(
      {Key? key,
      required this.emailController,
      required this.passwordController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      builder: (context, state) {
        return Column(
          children: [
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      UserCubit.get(context).signIn(
                          email: emailController.text,
                          password: passwordController.text);
                    },
                    child: const Text("SignIn"))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("If u don't have an Account"),
                TextButton(
                    onPressed: () {
                      buildPushReplacement(context, const SignUpScreen());
                    },
                    child: const Text("Sign Up"))
              ],
            )
          ],
        );
      },
      listener: (context, state) {
        if (state is UserLoginSuccessState) {
          buildPushReplacement(context, const SocialLayout());
        } else if (state is UserLoginErrorState) {
          SnackBar snackBar =
              const SnackBar(content: Text("Check Email And Password"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );
  }
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_cubit.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_states.dart';

import '../../ViewModels/Components/Components.dart';
import '../../Views/LayoutScreen/layout_screen.dart';
import '../../Views/SignInScreen/signIn_screen.dart';

class SignUpActions extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController phoneController;

  const SignUpActions(
      {Key? key,
      required this.passwordController,
      required this.emailController,
      required this.nameController,
      required this.phoneController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      builder: (context, state) {
        return Column(
          children: [
            ConditionalBuilder(
              condition: state is! UserRegisterLoadingState,
              builder: (BuildContext context) {
                return Center(
                    child: ElevatedButton(
                        onPressed: () {
                          UserCubit.get(context).register(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              phone: phoneController.text);
                        },
                        child: const Text("SignUp")));
              },
              fallback: (BuildContext context) {
                return const CircularProgressIndicator();
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("If u already have an Account"),
                TextButton(
                    onPressed: () {
                      buildPushReplacement(context, const SignInScreen());
                    },
                    child: const Text("Sign In")),
              ],
            )
          ],
        );
      },
      listener: (context, state) {
        if (state is UserRegisterSuccessState) {
          SnackBar snackBar =
          const SnackBar(content: Text("Register Done Successfully"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          buildPushReplacement(context, const SocialLayout());
        }
      });
  }
}

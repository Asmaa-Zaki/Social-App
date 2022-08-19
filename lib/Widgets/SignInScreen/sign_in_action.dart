import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Constants/constants.dart';

import '../../ViewModels/Bloc/UserCubit/user_cubit.dart';
import '../../ViewModels/Bloc/UserCubit/user_states.dart';
import '../../ViewModels/Components/Components.dart';
import '../../Views/LayoutScreen/layout_screen.dart';
import '../../Views/SignUpScreen/signUp_screen.dart';

class SignInActions extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> loginKey;

  const SignInActions(
      {Key? key,
      required this.emailController,
      required this.passwordController,
      required this.loginKey})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            BlocConsumer<UserCubit, UserStates>(
              builder: (context, state) {
                return ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            secondDefaultColor.withOpacity(.7))),
                    onPressed: () {
                      if (loginKey.currentState!.validate()) {
                        UserCubit.get(context).signIn(
                            email: emailController.text,
                            password: passwordController.text);
                      }
                    },
                    child: const Text(
                      "SIGN IN",
                      style: TextStyle(fontSize: 17),
                    ));
              },
              listener: (context, state) {
                if (state is UserLoginSuccessState) {
                  buildPushReplacement(context, const SocialLayout());
                } else if (state is UserLoginErrorState) {
                  SnackBar snackBar =
                      SnackBar(content: Text(state.errorMessage));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text("Create an Account?  "),
              InkWell(
                  onTap: () {
                    buildPushReplacement(context, const SignUpScreen());
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: secondDefaultColor.withOpacity(.8),
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        )
      ],
    );
  }
}

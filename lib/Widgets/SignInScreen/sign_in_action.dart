import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
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
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            const Spacer(),
            BlocConsumer<UserCubit, UserStates>(
              builder: (context, state) {
                return ConditionalBuilder(
                  condition: state is! UserLoginLoadingState,
                  builder: (BuildContext context) {
                    return ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(secondDefaultColor)),
                        onPressed: () {
                          if (loginKey.currentState!.validate()) {
                            UserCubit.get(context).signIn(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 17),
                        ));
                  },
                  fallback: (BuildContext context) {
                    return const CircularProgressIndicator();
                  },
                );
              },
              listener: (context, state) {
                if (state is UserLoginSuccessState) {
                  buildPushReplacement(context, const SocialLayout());
                } else if (state is UserLoginErrorState) {
                  showSnackBar(context, state.errorMessage);
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
                    "Register",
                    style: TextStyle(
                        color: secondDefaultColor, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        )
      ],
    );
  }
}

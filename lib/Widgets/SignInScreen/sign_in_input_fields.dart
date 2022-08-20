import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_cubit.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_states.dart';

import '../SharedWidgets/BuildText/build_text_form_field.dart';

class SignInInputFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const SignInInputFields(
      {Key? key,
      required this.emailController,
      required this.passwordController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildTextFormField(
            controller: emailController,
            label: "Email",
            keyboard: TextInputType.emailAddress,
            validate: (val) {
              if (val!.isEmpty) {
                return "Email is Required";
              }
              return null;
            }),
        const SizedBox(
          height: 30,
        ),
        BlocConsumer<UserCubit, UserStates>(
          builder: (context, state) {
            bool isInVisible = UserCubit.get(context).isPasswordInVisible;
            return BuildTextFormField(
                controller: passwordController,
                label: "Password",
                obscureText: isInVisible,
                keyboard: TextInputType.streetAddress,
                showPassword: () {
                  UserCubit.get(context).changeLoginPassword();
                },
                postFix: !isInVisible ? Icons.visibility : Icons.visibility_off,
                validate: (val) {
                  if (val!.isEmpty) {
                    return "Password is Required";
                  }
                  return null;
                });
          },
          listener: (context, state) {},
        ),
      ],
    );
  }
}

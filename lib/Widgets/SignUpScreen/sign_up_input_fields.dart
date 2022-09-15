import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_cubit.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_states.dart';

import '../SharedWidgets/BuildTextForm/build_text_form_field.dart';

class SignUpInputFields extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController phoneController;

  const SignUpInputFields(
      {Key? key,
      required this.passwordController,
      required this.emailController,
      required this.nameController,
      required this.phoneController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          BuildTextFormField(
              controller: nameController,
              label: "Name",
              validate: (val) {
                if (val!.isEmpty) {
                  return "Name is Required";
                }
                return null;
              }),
          const SizedBox(
            height: 20,
          ),
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
            height: 20,
          ),
          BuildTextFormField(
              controller: phoneController,
              label: "Phone",
              keyboard: TextInputType.phone,
              validate: (val) {
                if (val!.isEmpty) {
                  return "Phone is Required";
                }
                return null;
              }),
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<UserCubit, UserStates>(
            builder: (context, state) {
              bool isInVisible = UserCubit.get(context).isPasswordInVisible;
              return BuildTextFormField(
                  controller: passwordController,
                  label: "Password",
                  obscureText: isInVisible,
                  showPassword: () {
                    UserCubit.get(context).changeLoginPassword();
                  },
                  postFix:
                      !isInVisible ? Icons.visibility : Icons.visibility_off,
                  keyboard: TextInputType.streetAddress,
                  validate: (val) {
                    if (val!.isEmpty) {
                      return "Password is Required";
                    }
                    return null;
                  });
            },
            listener: (context, state) {},
          )
        ],
      ),
    );
  }
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_cubit.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_states.dart';
import 'package:social_app/ViewModels/Constants/constants.dart';

import '../../ViewModels/Components/components.dart';
import '../../Views/LayoutScreen/layout_screen.dart';
import '../../Views/SignInScreen/signIn_screen.dart';

class SignUpActions extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final GlobalKey<FormState> signUpKey;

  const SignUpActions(
      {Key? key,
      required this.passwordController,
      required this.emailController,
      required this.nameController,
      required this.phoneController,
      required this.signUpKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            height: 15,
          ),
          BlocConsumer<UserCubit, UserStates>(builder: (context, state) {
            return ConditionalBuilder(
              condition: state is! UserRegisterLoadingState,
              builder: (BuildContext context) {
                return ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            secondDefaultColor.withOpacity(.8))),
                    onPressed: () {
                      if (signUpKey.currentState!.validate()) {
                        UserCubit.get(context).register(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text,
                            phone: phoneController.text);
                      }
                    },
                    child: const Text("Register",
                      style: TextStyle(fontSize: 17),));
              },
              fallback: (BuildContext context) {
                return const CircularProgressIndicator();
              },
            );
          }, listener: (context, state) {
            if (state is UserRegisterErrorState) {
              showSnackBar(context, state.errorMessage);
            } else if (state is UserRegisterSuccessState) {
              buildPushReplacement(context, const SocialLayout());
            }
          }),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Have an Account?  "),
                InkWell(
                    onTap: () {
                      buildPushReplacement(context, const SignInScreen());
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: secondDefaultColor.withOpacity(.8),
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

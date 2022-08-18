import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_cubit.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_states.dart';

import 'ViewModels/Bloc/BlocObserver/BlocObserver.dart';
import 'ViewModels/Bloc/ChatCubit/chat_cubit.dart';
import 'ViewModels/Bloc/PostCubit/post_cubit.dart';
import 'ViewModels/Bloc/PostCubit/post_states.dart';
import 'ViewModels/Constants/constants.dart';
import 'ViewModels/Local/CacheHelper.dart';
import 'Views/LayoutScreen/layout_screen.dart';
import 'Views/SignInScreen/signIn_screen.dart';

main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      await CacheHelper.init();
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget currentWidget;
    if (uId == null) {
      currentWidget = const SignInScreen();
    } else {
      currentWidget = const SocialLayout();
    }
    return MultiBlocProvider(
        providers: [
          BlocProvider<ChatCubit>(create: (context) => ChatCubit()),
          BlocProvider<PostCubit>(create: (context) => PostCubit()..getPosts()),
          BlocProvider<UserCubit>(
              create: (context) => UserCubit()
                ..getUser()
                ..getUsers()),
        ],
        child: BlocConsumer<UserCubit, UserStates>(
          builder: (context, state) {
            return BlocConsumer<PostCubit, PostAppStates>(
                builder: (context, state) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: currentWidget,
                    theme: ThemeData(
                        primarySwatch: Colors.blueGrey,
                        primaryColor: Colors.blueGrey.shade900,
                        appBarTheme: AppBarTheme(
                            backgroundColor: Colors.blueGrey.shade900)),
                  );
                },
                listener: (context, state) {});
          },
          listener: (context, state) {},
        ));
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/ThemeCubit/theme_cubit.dart';
import 'package:social_app/ViewModels/Bloc/ThemeCubit/theme_states.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_cubit.dart';
import 'package:social_app/Views/LayoutScreen/layout_screen.dart';
import 'package:social_app/Widgets/Themes/dark_theme.dart';
import 'package:social_app/Widgets/Themes/light_theme.dart';

import 'ViewModels/Bloc/BlocObserver/BlocObserver.dart';
import 'ViewModels/Bloc/ChatCubit/chat_cubit.dart';
import 'ViewModels/Bloc/PostCubit/post_cubit.dart';
import 'ViewModels/Constants/constants.dart';
import 'ViewModels/Local/CacheHelper.dart';
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
          BlocProvider<PostCubit>(
              create: (context) => PostCubit()..getPosts(false)),
          BlocProvider<UserCubit>(
              create: (context) => UserCubit()
                ..getUser()
                ..getUsers()),
          BlocProvider<ThemeCubit>(create: (context) => ThemeCubit())
        ],
        child: BlocBuilder<ThemeCubit, ThemeStates>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: currentWidget,
              darkTheme: darkTheme(),
              theme: lightTheme(),
              themeMode: ThemeCubit.get(context).darkTheme
                  ? ThemeMode.dark
                  : ThemeMode.light,
            );
          },
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/FriendBloc/friend_cubit.dart';

import '../../../ViewModels/Bloc/ChatCubit/chat_cubit.dart';
import '../../../ViewModels/Bloc/CommentCubit/comment_cubit.dart';
import '../../../ViewModels/Bloc/PostCubit/post_cubit.dart';
import '../../../ViewModels/Bloc/ThemeCubit/theme_cubit.dart';
import '../../../ViewModels/Bloc/ThemeCubit/theme_states.dart';
import '../../../ViewModels/Bloc/UserCubit/user_cubit.dart';
import '../../../ViewModels/Constants/constants.dart';
import '../../../Views/LayoutScreen/layout_screen.dart';
import '../../../Views/SignInScreen/signIn_screen.dart';
import '../Themes/dark_theme.dart';
import '../Themes/light_theme.dart';

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
          BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
          BlocProvider<CommentCubit>(create: (context) => CommentCubit()),
          BlocProvider<FriendCubit>(
              create: (context) => FriendCubit()..getAllFriendsDetails(false)),
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

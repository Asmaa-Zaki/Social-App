import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/NavigationCubit/navigation_cubit.dart';
import 'package:social_app/ViewModels/Bloc/NavigationCubit/navigation_states.dart';
import 'package:social_app/ViewModels/Bloc/NotificationCubit/notification_states.dart';
import 'package:social_app/ViewModels/Constants/constants.dart';
import 'package:social_app/Widgets/LayoutScreen/layout_appbar.dart';

import '../../ViewModels/Bloc/NotificationCubit/notification_cubit.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<NavigationCubit>(create: (context) => NavigationCubit()),
          BlocProvider<NotificationCubit>(
              create: (context) => NotificationCubit()),
        ],
        child: Builder(builder: (context) {
          NotificationCubit.get(context).getNotifications(context);
          return BlocBuilder<NotificationCubit, NotificationStates>(
            builder: (context, state) =>
                BlocBuilder<NavigationCubit, NavigationState>(
              builder: (context, state) {
                statusBarHeight = MediaQuery.of(context).padding.top;
                heightScreen = MediaQuery.of(context).size.height;
                int currentIndex = NavigationCubit.get(context).currentIndex;
                return Scaffold(
                  appBar: PreferredSize(
                      preferredSize:
                          Size.fromHeight(currentIndex == 0 ? 106.20 : 56.20),
                      child: const LayoutAppbar()),
                  body: NavigationCubit.get(context)
                      .screens[NavigationCubit.get(context).currentIndex],
                );
              },
            ),
          );
        }));
  }
}

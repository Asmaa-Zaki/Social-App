import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/NavigationCubit/navigation_states.dart';
import 'package:social_app/ViewModels/Bloc/NotificationCubit/notification_cubit.dart';
import 'package:social_app/Views/NotificationScreen/notification_screen.dart';

import '../../../Views/HomeScreen/home_screen.dart';
import '../../../Views/ProfileScreen/profile_screen.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitState());

  static NavigationCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const NotificationScreen(),
    const SettingsScreen(),
  ];

  static bool newNotifications = false;
  changeNotificationState(bool state) {
    newNotifications = state;
    emit(ChangeNotificationState());
  }

  changeIndex(int current, BuildContext context) {
    currentIndex = current;
    if (currentIndex == 1) {
      changeNotificationState(false);
      NotificationCubit.get(context).updateAllNotifications();
    }
    emit(NavigationChange());
  }
}

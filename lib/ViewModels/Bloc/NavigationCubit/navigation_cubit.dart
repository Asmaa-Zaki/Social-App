import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/NavigationCubit/navigation_states.dart';

import '../../../Views/HomeScreen/home_screen.dart';
import '../../../Views/ProfileScreen/profile_screen.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitState());

  static NavigationCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;
  
  List<Widget> screens = [
    const HomeScreen(),
    //const ChatsScreen(),
    //const PostsScreen(),
    //const UsersScreen(),
    const SettingsScreen(),
  ];

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    //BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
    // BottomNavigationBarItem(icon: Icon(Icons.add), label: "Posts"),
    //BottomNavigationBarItem(icon: Icon(Icons.person), label: "Users"),
    BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Settings"),
  ];

  changeIndex(int current, BuildContext context) {
    /*if (current == 1) {
     // buildPush(context, const PostsScreen());
    } else {*/
    currentIndex = current;
    // }
    emit(NavigationChange());
  }
}

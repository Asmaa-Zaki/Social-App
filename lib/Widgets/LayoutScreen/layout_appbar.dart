import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/NavigationCubit/navigation_states.dart';

import '../../ViewModels/Bloc/NavigationCubit/navigation_cubit.dart';
import '../../ViewModels/Components/Components.dart';
import '../../Views/ChatsList/chats_list.dart';
import '../../Views/CreatePostScreen/create_post_screen.dart';
import '../../Views/NewUsers/new_users.dart';

class LayoutAppbar extends StatelessWidget {
  const LayoutAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        int currentIndex = NavigationCubit.get(context).currentIndex;
        List<BottomNavigationBarItem> items = [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  const Icon(Icons.notifications),
                  if (NavigationCubit.newNotifications)
                    const CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.blue,
                    )
                ],
              ),
              label: "Notifications"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.menu), label: "Settings"),
        ];
        //  remember to edit items
        //  List<BottomNavigationBarItem> items= NavigationCubit.get(context).items;
        return SafeArea(
          child: Column(
            children: [
              if (currentIndex == 0)
                SizedBox(
                    height: 50,
                    child: Row(children: [
                      const SizedBox(
                        width: 15,
                      ),
                      CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 16,
                          child: IconButton(
                              onPressed: () {
                                buildPush(
                                    context, const StartChatWithFriends());
                              },
                              icon: const Icon(
                                Icons.messenger_rounded,
                                size: 16,
                              ))),
                      const SizedBox(
                        width: 15,
                      ),
                      CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 16,
                          child: IconButton(
                              onPressed: () {
                                buildPush(context, const PostScreen());
                              },
                              icon: const Icon(Icons.add, size: 16))),
                      const SizedBox(
                        width: 15,
                      ),
                      CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 16,
                          child: IconButton(
                              onPressed: () {
                                buildPush(context, const NewUsersScreen());
                              },
                              icon: const Icon(Icons.person, size: 16))),
                      const Spacer(),
                      const Text(
                        "Social App",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      )
                    ])),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: .20,
                            color: Theme.of(context).iconTheme.color ??
                                Colors.black))),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  items: items,
                  currentIndex: NavigationCubit.get(context).currentIndex,
                  onTap: (val) {
                    NavigationCubit.get(context).changeIndex(val, context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

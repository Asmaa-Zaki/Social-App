import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/NavigationCubit/navigation_states.dart';

import '../../ViewModels/Bloc/NavigationCubit/navigation_cubit.dart';
import '../../ViewModels/Components/Components.dart';
import '../../Views/ChatsList/chats_list.dart';
import '../../Views/CreatePostScreen/create_post_screen.dart';

class LayoutAppbar extends StatelessWidget {
  const LayoutAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NavigationCubit, NavigationState>(
      builder: (context, state){
        return SafeArea(
          child: Column(
            children: [
              if(NavigationCubit.get(context).currentIndex != 1)
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
                                buildPush(context, const ChatsScreen());
                              },
                              icon: const Icon(
                                Icons.messenger_rounded,
                                size: 18,
                              ))),
                      const SizedBox(
                        width: 15,
                      ),
                      CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 16,
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.search, size: 18))),
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
                              icon: const Icon(Icons.add, size: 18))),
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
              BottomNavigationBar(
                elevation: 3,
                type: BottomNavigationBarType.fixed,
                items: NavigationCubit.get(context).items,
                currentIndex: NavigationCubit.get(context).currentIndex,
                onTap: (val) {
                  NavigationCubit.get(context)
                      .changeIndex(val, context);
                },
              ),
            ],
          ),
        );
      },
      listener: (context, state){},
    );
  }
}

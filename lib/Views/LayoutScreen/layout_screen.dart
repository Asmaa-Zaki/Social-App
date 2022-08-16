import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/NavigationCubit/navigation_cubit.dart';
import 'package:social_app/ViewModels/Bloc/NavigationCubit/navigation_states.dart';
import 'package:social_app/Widgets/LayoutScreen/layout_appbar.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationCubit>(
        create: (context) => NavigationCubit(),
        child: BlocConsumer<NavigationCubit, NavigationState>(
          builder: (BuildContext context, state) {
            return Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(
                      NavigationCubit.get(context).currentIndex != 1
                          ? 106
                          : 56),
                  child: const LayoutAppbar()),
              body: NavigationCubit.get(context)
                  .screens[NavigationCubit.get(context).currentIndex],
            );
          },
          listener: (BuildContext context, Object? state) {},
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/ThemeCubit/theme_cubit.dart';
import 'package:social_app/ViewModels/Bloc/ThemeCubit/theme_states.dart';
import 'package:social_app/ViewModels/Local/cache_helper.dart';

class DarkThemeAction extends StatelessWidget {
  const DarkThemeAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          const Icon(Icons.light_mode),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Dark Theme",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          const Spacer(),
          BlocConsumer<ThemeCubit, ThemeStates>(
              builder: (context, state) {
                return Switch(
                    value: ThemeCubit.get(context).darkTheme,
                    onChanged: (value) {
                      ThemeCubit.get(context).changeAppTheme(value);
                      CacheHelper.setData(key: "dark", value: value);
                    });
              },
              listener: (context, state) {}),
        ],
      ),
    );
  }
}

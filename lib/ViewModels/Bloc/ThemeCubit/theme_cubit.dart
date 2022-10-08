import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Local/cache_helper.dart';
import 'theme_states.dart';

class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(ThemeInitState());
  static ThemeCubit get(BuildContext context) => BlocProvider.of(context);

  bool darkTheme = CacheHelper.getData(key: "dark") ?? false;

  changeAppTheme(bool value) {
    darkTheme = value;
    emit(ThemeChangedState());
  }
}

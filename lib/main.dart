import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ViewModels/Bloc/BlocObserver/BlocObserver.dart';
import 'ViewModels/Local/CacheHelper.dart';
import 'Widgets/Main/MyApp/my_app.dart';

main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  runApp(const MyApp());
}

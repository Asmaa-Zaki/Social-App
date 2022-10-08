import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Components/components.dart';
import 'package:social_app/ViewModels/Network/dio_helper.dart';

import 'ViewModels/Bloc/BlocObserver/BlocObserver.dart';
import 'ViewModels/Constants/constants.dart';
import 'ViewModels/Local/cache_helper.dart';
import 'Widgets/Main/MyApp/my_app.dart';

main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  await DioHelper.init();
  deviceToken = await FirebaseMessaging.instance.getToken();
  firebaseMessageListening();
  runApp(const MyApp());
}

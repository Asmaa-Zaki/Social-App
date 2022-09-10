import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String? uId = FirebaseAuth.instance.currentUser?.uid;

Color firstDefaultColor = Colors.blueGrey.shade900;
Color secondDefaultColor = Colors.blueGrey;
Color defaultDarkColor = Colors.grey.shade900;

final timeFormat = DateFormat.jm();
final dateFormat = DateFormat.yMd();

double? statusBarHeight;
double? heightScreen;

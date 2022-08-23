import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String? uId = FirebaseAuth.instance.currentUser?.uid;

Color firstDefaultColor = Colors.blueGrey.shade900;
Color secondDefaultColor = Colors.blue.shade900;

final minuteFormat = DateFormat.jm();
final dateFormat = DateFormat.yMd();

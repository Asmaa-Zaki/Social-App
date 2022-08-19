import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String? uId = FirebaseAuth.instance.currentUser?.uid;

Color firstDefaultColor = Colors.blueGrey.shade900;
Color secondDefaultColor = Colors.blue.shade900;

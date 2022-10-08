import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Models/NotificationModel/notification_data_model.dart';
import 'package:social_app/Models/NotificationModel/notification_model.dart';
import 'package:social_app/ViewModels/Constants/constants.dart';
import 'package:social_app/Views/NewUsers/new_users.dart';
import 'package:social_app/Views/ShowPostScreen/show_post.dart';

import '../../Views/ChatsList/chats_list.dart';
import '../Bloc/UserCubit/user_cubit.dart';
import '../Network/dio_helper.dart';

Future<dynamic> buildPushReplacement(BuildContext context, Widget screen) {
  return Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) {
    return screen;
  }));
}

Future<dynamic> buildPush(BuildContext context, Widget screen) {
  return Navigator.push(context, MaterialPageRoute(builder: (context) {
    return screen;
  }));
}

void showSnackBar(BuildContext context, String message) {
  SnackBar snackBar = SnackBar(
      content: Text(
    message,
    style: const TextStyle(color: Colors.white),
  ));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void firebaseMessageListening() {
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    String screen = event.data['screen'];
    if (screen == "postScreen") {
      buildPush(navigatorKey.currentContext!,
          ShowPostScreen(postId: event.data['postId']));
    } else if (screen == "chatsScreen") {
      buildPush(navigatorKey.currentContext!, const StartChatWithFriends());
    } else if (screen == "usersScreen") {
      buildPush(navigatorKey.currentContext!, const NewUsersScreen());
    }
  });
  FirebaseMessaging.onMessage.listen((event) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
      channelKey: 'chats',
      id: 0,
      title: event.data["title"],
      body: event.data["body"],
    ));
  });
}

late ShowNotificationModel _newNotification;
sendNotification(
    {required BuildContext context,
    required String body,
    required String title,
    required String userId,
    required String screen,
    String? friendId,
    postId}) {
  _newNotification = ShowNotificationModel(
      registrationIds: UserCubit.get(context).activeDevices,
      body: body,
      title: title,
      sound: true,
      postId: postId,
      friendId: friendId,
      apnsPriority: '5',
      apnsPushType: 'background',
      urgency: 'high',
      priority: 'high',
      screen: screen);
  if (UserCubit.get(context).activeDevices.isNotEmpty) {
    DioHelper.postData(data: _newNotification.toMap());
  }
}

addNotificationToFirebase(
    String postUserId, String body, String currentUserId) {
  FirebaseFirestore.instance
      .collection("Notifications")
      .doc(postUserId)
      .collection("Notifications")
      .where("postId", isEqualTo: _newNotification.postId!)
      .where("body", isEqualTo: body)
      .get()
      .then((value) {
    if (value.docs.isNotEmpty) {
      NotificationDataModel notificationData =
          NotificationDataModel.fromJson(value.docs.first.data());
      List<dynamic> usersList = List.of(notificationData.friendId);
      usersList.add(currentUserId);
      notificationData.friendId = usersList.toSet().toList();
      value.docs.first.reference.update(notificationData.toMap());
    } else {
      addNewNotificationToFirebase(postUserId, body, currentUserId);
    }
  });
}

addNewNotificationToFirebase(
    String postUserId, String body, String currentUserId) {
  NotificationDataModel notificationData = NotificationDataModel(
    body: body,
    postId: _newNotification.postId!,
    time: DateTime.now().toString(),
    friendId: [currentUserId],
    newState: true,
    seen: false,
  );
  FirebaseFirestore.instance
      .collection("Notifications")
      .doc(postUserId)
      .collection("Notifications")
      .add(notificationData.toMap());
}

removeNotificationFromFirebase(String postUserId, String postId, String body) {
  FirebaseFirestore.instance
      .collection("Notifications")
      .doc(postUserId)
      .collection("Notifications")
      .where("postId", isEqualTo: postId)
      .where("friendId", arrayContains: uId)
      .where("body", isEqualTo: body)
      .get()
      .then((value) {
    if (value.docs.first.data()["friendId"].length > 1) {
      NotificationDataModel notificationData =
          NotificationDataModel.fromJson(value.docs.first.data());
      var usersList = List.of(notificationData.friendId);
      usersList.remove(uId);
      notificationData.friendId = usersList;
      value.docs.first.reference.update(notificationData.toMap());
    } else {
      value.docs.first.reference.delete();
    }
  });
}

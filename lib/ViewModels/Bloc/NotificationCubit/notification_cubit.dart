import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Models/NotificationModel/notification_data_model.dart';
import 'package:social_app/ViewModels/Bloc/NavigationCubit/navigation_cubit.dart';

import '../../../Models/UserModel/user_model.dart';
import '../../Constants/constants.dart';
import 'notification_states.dart';

class NotificationCubit extends Cubit<NotificationStates> {
  NotificationCubit() : super(NotificationInit());

  static NotificationCubit get(BuildContext context) =>
      BlocProvider.of(context);

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  List<NotificationDataModel> notifications = [];
  getNotifications(BuildContext context) {
    _firebaseFirestore
        .collection("Notifications")
        .doc(uId!)
        .collection("Notifications")
        .orderBy("time", descending: true)
        .snapshots()
        .listen((event) {
      notifications.clear();
      for (var element in event.docs) {
        notifications.add(NotificationDataModel.fromJson(element.data()));
        if (element.data()["new"] == true) {
          NavigationCubit.get(context).changeNotificationState(true);
        }
      }
      emit(GetNotificationSuccessfully());
    });
  }

  updateAllNotifications() {
    _firebaseFirestore
        .collection("Notifications")
        .doc(uId!)
        .collection("Notifications")
        .where("new", isEqualTo: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        Map<String, dynamic> data = element.data();
        data["new"] = false;
        element.reference.update(data);
      }
    });
  }

  updateSelectedNotifications(String postId, String body) {
    _firebaseFirestore
        .collection("Notifications")
        .doc(uId!)
        .collection("Notifications")
        .where(
          "postId",
          isEqualTo: postId,
        )
        .where("body", isEqualTo: body)
        .get()
        .then((value) {
      Map<String, dynamic> data = value.docs.first.data();
      data["seen"] = true;
      value.docs.first.reference.update(data);
    });
  }

  getNotificationData(
      List<UserModel> notificationUsers, NotificationDataModel notification) {
    List<String> notificationBody = notification.body.split(" ");
    List<String> notificationData = [];
    for (var element in notificationUsers) {
      notificationData.add(element.name);
      if (element.uId != notificationUsers.last.uId &&
          notificationUsers.length > 1) {
        notificationData.add(",");
      }

      if (element.uId == notificationUsers.last.uId) {
        for (var element in notificationBody) {
          notificationData.add(element);
        }
      }
    }
    return notificationData;
  }
}

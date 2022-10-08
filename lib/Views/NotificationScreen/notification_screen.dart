import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Models/NotificationModel/notification_data_model.dart';
import 'package:social_app/Models/UserModel/user_model.dart';
import 'package:social_app/ViewModels/Bloc/NotificationCubit/notification_cubit.dart';
import 'package:social_app/ViewModels/Bloc/NotificationCubit/notification_states.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_cubit.dart';
import 'package:social_app/ViewModels/Components/components.dart';
import 'package:social_app/ViewModels/Constants/constants.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../ShowPostScreen/show_post.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationStates>(
      builder: (context, state) {
        List<NotificationDataModel> notifications =
            NotificationCubit.get(context).notifications;
        return ListView.separated(
            itemBuilder: (context, index) {
              List<UserModel> notificationUsers = UserCubit.get(context)
                  .getUsersWithId(notifications[index].friendId)!;

              List<String> notificationData = NotificationCubit.get(context)
                  .getNotificationData(notificationUsers, notifications[index]);

              return Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  color: notifications[index].seen
                      ? Theme.of(context).scaffoldBackgroundColor
                      : firstDefaultColor.withOpacity(.2),
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            NetworkImage(notificationUsers.first.image)),
                    title: Wrap(
                      children: notificationData.map((data) {
                        return Text(" " + data + "");
                      }).toList(),
                    ),
                    subtitle: Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          timeago.format(
                              DateTime.parse(notifications[index].time)),
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        )),
                    onTap: () {
                      NotificationCubit.get(context)
                          .updateSelectedNotifications(
                              notifications[index].postId,
                              notifications[index].body);
                      buildPush(
                          context,
                          ShowPostScreen(
                            postId: notifications[index].postId,
                          ));
                    },
                  ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: notifications.length);
      },
    );
  }
}

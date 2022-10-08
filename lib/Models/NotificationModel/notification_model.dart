import 'package:flutter/cupertino.dart';

class ShowNotificationModel {
  final List<String> registrationIds;
  final String body;
  final String title;
  final bool sound;
  final String priority;
  final String apnsPriority;
  final String apnsPushType;
  final String urgency;
  final String? postId;
  final String? friendId;
  late String screen;

  ShowNotificationModel(
      {required this.priority,
      required this.apnsPriority,
      required this.apnsPushType,
      required this.urgency,
      required this.registrationIds,
      required this.body,
      required this.title,
      required this.sound,
      required this.screen,
      this.friendId,
      @required this.postId});

  Map<String, dynamic> toMap() {
    return {
      "registration_ids": registrationIds,
      "data": _DataModel(body, title, sound, postId, screen, friendId).toMap(),
      "notification":
          _DataModel(body, title, sound, postId, screen, friendId).toMap(),
      "android": AndroidModel(priority).toMap(),
      "apns": APNSModel(apnsPriority, apnsPushType).toMap(),
      "webpush": WebPush(urgency).toMap(),
    };
  }
}

class _DataModel {
  final String body;
  final String title;
  final bool sound;
  final String? postId;
  final String? friendId;
  final String? screen;

  _DataModel(this.body, this.title, this.sound, this.postId, this.screen,
      this.friendId);

  Map<String, dynamic> toMap() {
    return {
      "body": body,
      "title": title,
      "sound": sound,
      "postId": postId,
      "screen": screen,
      "friendId": friendId,
    };
  }
}

class AndroidModel {
  final String priority;
  AndroidModel(this.priority);

  toMap() {
    return {"priority": priority};
  }
}

class APNSModel {
  final String apnsPriority;
  final String apnsPushType;

  APNSModel(this.apnsPriority, this.apnsPushType);
  toMap() {
    return {
      "headers": {"apns-priority": apnsPriority, "apns-push-type": apnsPushType}
    };
  }
}

class WebPush {
  final String urgency;

  WebPush(this.urgency);
  toMap() {
    return {
      "headers": {"Urgency": urgency}
    };
  }
}

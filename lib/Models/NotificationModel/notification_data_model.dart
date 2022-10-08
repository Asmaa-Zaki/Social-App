class NotificationDataModel {
  late String body;
  late String postId;
  late List<dynamic> friendId;
  late String time;
  late bool seen;
  late bool newState;

  NotificationDataModel(
      {required this.body,
      required this.postId,
      required this.time,
      required this.friendId,
      required this.newState,
      required this.seen});

  NotificationDataModel.fromJson(Map<String, dynamic> data) {
    body = data["body"];
    postId = data["postId"];
    friendId = data["friendId"];
    time = data["time"];
    seen = data["seen"];
    newState = data["new"];
  }

  toMap() {
    return {
      "body": body,
      "postId": postId,
      "friendId": friendId,
      "time": time,
      "seen": seen,
      "new": newState
    };
  }
}

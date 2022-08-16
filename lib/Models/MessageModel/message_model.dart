class MessageModel {
  late String message;
  late String senderId;
  late String receiverId;
  late String dateTime;

  MessageModel(
      {required this.message,
      required this.dateTime,
      required this.senderId,
      required this.receiverId});

  MessageModel.fromJson(Map<String, dynamic> data) {
    message = data["message"];
    senderId = data["senderId"];
    receiverId = data["receiverId"];
    dateTime = data["dateTime"];
  }

  Map<String, dynamic> toMap() {
    return {
      "message": message,
      "senderId": senderId,
      "receiverId": receiverId,
      "dateTime": dateTime,
    };
  }
}

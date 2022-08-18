class MessageModel {
  String? message;
  late String senderId;
  late String receiverId;
  late String dateTime;
  String? image;

  MessageModel(
      {required this.message,
      required this.dateTime,
      required this.senderId,
      required this.receiverId,
      required this.image});

  MessageModel.fromJson(Map<String, dynamic> data) {
    message = data["message"];
    senderId = data["senderId"];
    receiverId = data["receiverId"];
    dateTime = data["dateTime"];
    image = data["image"];
  }

  Map<String, dynamic> toMap() {
    return {
      "message": message,
      "senderId": senderId,
      "receiverId": receiverId,
      "dateTime": dateTime,
      "image": image,
    };
  }
}

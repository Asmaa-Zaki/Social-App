class PostModel {
  late String? uId;
  late String? text;
  late String? postImage;
  late String? dateTime;

  PostModel({this.uId, this.postImage, this.text, this.dateTime});

  PostModel.fromJson(Map<String, dynamic> data) {
    uId = data["uId"];
    text = data["text"];
    postImage = data["postImage"];
    dateTime = data["dateTime"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uId": uId,
      "dateTime": dateTime,
      "postImage": postImage,
      "text": text,
    };
  }
}

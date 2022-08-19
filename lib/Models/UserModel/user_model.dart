class UserModel {
  late String name;
  late String email;
  late String phone;
  late String password;
  late String uId;
  late String image;
  late String cover;
  late String dio;

  UserModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.password,
      required this.uId,
      required this.image,
      required this.cover,
      required this.dio});

  UserModel.fromJson(Map<String, dynamic> data) {
    name = data["name"];
    email = data["email"];
    phone = data["phone"];
    password = data["password"];
    uId = data["uId"];
    image = data["image"];
    cover = data["cover"];
    dio = data["dio"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "image": image,
      "cover": cover,
      "dio": dio,
      "uId": uId
    };
  }
}

import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: "https://fcm.googleapis.com/fcm/",
      receiveDataWhenStatusError: true,
    ));
  }

  static Future postData({Map<String, dynamic>? data}) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      "Authorization":
          "key=AAAAT1EaiEs:APA91bGQmCErYWdbLx1-_L7PUk2Kb2vBr56tneD9dnDPx6etyjhwP2n8RyNJyL2tJzeY-9aiNK2PVqbh99rKiq34bAyHxjhER7_Fsvls-phUI7VqVFHAp_srEpF8EFEcY5-u47dQcPxV"
    };
    return await dio.post(
      "send",
      data: data,
    );
  }
}

import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://newsapi.org/', receiveDataWhenStatusError: true));
  }

  static Future getData({
    required String url,
    required quary,
  }) async =>
      await dio.get(url, queryParameters: quary);
}

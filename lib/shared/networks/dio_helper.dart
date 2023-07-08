import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: "https://student.valuxapps.com/api/",
          receiveDataWhenStatusError: true,
          headers: {
            "Content-Type":"application/json",
          }),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = "en",
    String? token,
    String? authorization,
  }) async {
    dio!.options.headers = {
      "lang": lang,
      "token": token,
      "Authorization": authorization,
      "Content-Type": "application/json",
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = "en",
    String? token,
    String? authorization,
  }) async {
    dio!.options.headers = {
      "Content-Type": "application/json",
      "lang": lang,
      "Authorization": authorization,
      "token": token,
    };

    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> updateData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = "en",
    String? token,
    String? authorization,
  }) async {
    dio!.options.headers = {
      "Content-Type": "application/json",
      "lang": lang,
      "Authorization": authorization,
      "token": token,
    };

    return dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

   static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = "en",
    String? token,
    String? authorization,
  }) async {
    dio!.options.headers = {
      "Content-Type": "application/json",
      "lang": lang,
      "Authorization": authorization,
      "token": token,
    };

    return dio!.delete(
      url,
      queryParameters: query,
      data: data,
    );
  }
}

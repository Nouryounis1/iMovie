import 'package:dio/dio.dart';
import 'package:movies_app/API/api_constants.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(baseUrl: API_BASE_URL, receiveDataWhenStatusError: true),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    required Map<String, dynamic> data,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': 'en',
      'Authorization': token ?? ''
    };

    return await dio!.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    required Map<String, dynamic> data,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': 'en',
      'Authorization': token ?? ''
    };

    return await dio!.put(url, queryParameters: query, data: data);
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': 'en',
      'Authorization': token ?? ''
    };

    return await dio!.delete(url, queryParameters: query);
  }
}

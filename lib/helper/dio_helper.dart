import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/exceptions.dart';

class DioHelper {
  static late Dio dio;
  static const String baseURL = 'https://student.valuxapps.com/api/';

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseURL,
        receiveDataWhenStatusError: true,
        queryParameters: {},
      ),
    );
  }

  static Future<Response<dynamic>> getData({
    Map<String, dynamic>? query,
    required String url,
    String lang = 'en',
    String? token,
  }) async {
    try {
      dio.options.headers = {
        "Content-Type": "application/json",
        "lang": lang,
        "authorization": token ?? "",
      };
      return await dio.get(url, queryParameters: query);
    } on DioException catch (e) {
      var error = DioExceptions.fromDioError(e);
      throw error.errorMessage;
    }
  }

  static Future<Response<dynamic>> postData({
    Map<String, dynamic>? query,
    required String url,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    try {
      dio.options.headers = {
        "Content-Type": "application/json",
        "lang": lang,
        "authorization": token ?? "",
      };
      return await dio.post(url, queryParameters: query, data: data);
    } on DioException catch (e) {
      var error = DioExceptions.fromDioError(e);
      throw error.errorMessage;
    }
  }

  static Future<Response<dynamic>> putData({
    Map<String, dynamic>? query,
    required String url,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    try {
      dio.options.headers = {
        "Content-Type": "application/json",
        "lang": appLanguage,
        "authorization": token ?? "",
      };
      return await dio.put(
        url,
        data: data,
      );
    } on DioException catch (e) {
      var error = DioExceptions.fromDioError(e);
      throw error.errorMessage;
    }
  }
}

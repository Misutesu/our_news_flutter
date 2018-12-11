import 'package:dio/dio.dart';
import 'package:our_news_flutter/api.dart';

class DioUtils {
  static var dio = new Dio(new Options(
      baseUrl: baseUrl, connectTimeout: 5000, receiveTimeout: 3000));
}

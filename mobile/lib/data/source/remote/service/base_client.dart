import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseClient {

  static final BaseClient _instance = BaseClient._internal();
  final Dio _dio;

  factory BaseClient({String? baseUrl}) {
    if (_instance._dio.options.baseUrl.isEmpty) {
      _instance._dio.options.baseUrl = dotenv.env['BASE_URL'] ?? "";
      _instance._dio.interceptors.add(
        LogInterceptor(
          logPrint: (o) => debugPrint(o.toString()),
        ),
      );
    }
    return _instance;
  }

  BaseClient._internal() : _dio = Dio();

  void setBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParameters);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      return await _dio.put(endpoint, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      return await _dio.delete(endpoint, data: data);
    } catch (e) {
      rethrow;
    }
  }
}

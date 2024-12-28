import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ServerException {
  final int statusCode;
  final String message;

  ServerException({required this.statusCode, required this.message});

  @override
  String toString() {
    return message;
  }
}

extension ServerExceptionExt on Object {
  ServerException toServerException() {
    if(this is DioException) {
      DioException dioException = this as DioException;
      return ServerException(
          statusCode: dioException.response?.statusCode ?? -1,
          message: dioException.response?.data?['error'] ?? ""
      );
    }
    return ServerException(statusCode: -1, message: "");
  }
}

class BaseClient {

  static final BaseClient _instance = BaseClient._internal();
  final Dio _dio;

  factory BaseClient({String? baseUrl}) {
    if (_instance._dio.options.baseUrl.isEmpty || true) {
      final baseOptions = BaseOptions(
        baseUrl:  dotenv.env['BASE_URL'] ?? "",
        contentType: Headers.jsonContentType,
        // validateStatus: (int? status) {
        //   return status != null;
        //   // return status != null && status >= 200 && status < 300;
        // },
      );
      _instance._dio.options = baseOptions;
      _instance._dio.interceptors.addAll([
        LogInterceptor(
          logPrint: (o) => debugPrint(o.toString()),
        ),
      ]);
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

  Future<Response> post(String endpoint, {Map<String, dynamic>? data})  {
    return _dio.post(endpoint, data: data);
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

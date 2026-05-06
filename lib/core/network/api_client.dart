import 'package:dio/dio.dart';

import 'package:newsflow/core/error/exceptions.dart';
import 'package:newsflow/core/network/%20api_interceptor.dart';
import 'package:newsflow/core/storage/secure_storage.dart';
import 'package:newsflow/core/utils/app_config.dart';


class ApiClient {
  late final Dio _dio;

  ApiClient({required SecureStorage secureStorage}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      ApiInterceptor(
        secureStorage: secureStorage,
        dio: Dio(
          BaseOptions(baseUrl: AppConfig.baseUrl),
        ),
      ),
    );
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: body,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  Future<dynamic> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  Exception _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionError:
        return const NetworkException();

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = _extractErrorMessage(e.response);

        if (statusCode == 401) return const AuthException();

        return ServerException(
          message: message,
          statusCode: statusCode,
        );

      default:
        return ServerException(
          message: e.message ?? 'Something went wrong',
        );
    }
  }

  String _extractErrorMessage(Response? response) {
    try {
      if (response?.data is Map) {
        return response?.data['message'] as String? ??
            response?.data['error'] as String? ??
            'Something went wrong';
      }
      return 'Something went wrong';
    } catch (_) {
      return 'Something went wrong';
    }
  }
}
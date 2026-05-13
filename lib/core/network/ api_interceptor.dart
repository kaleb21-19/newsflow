
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:newsflow/core/network/api_endpoints.dart';
import 'package:newsflow/core/storage/secure_storage.dart';

class ApiInterceptor extends Interceptor {

  final SecureStorage _secureStorage;
  final Dio _dio;

  ApiInterceptor({required SecureStorage secureStorage, required Dio dio}): 
    _secureStorage = secureStorage,
    _dio = dio;

 @override
Future<void> onRequest(
  RequestOptions options,
  RequestInterceptorHandler handler,
) async {
  final token = await _secureStorage.getAccessToken();

  if (token != null) {
    options.headers['Authorization'] = 'Bearer $token';
  }

  if (kDebugMode) {
    debugPrint('→ ${options.method} ${options.path}');
  }

  handler.next(options);
}
@override
void onResponse(
  Response response,
  ResponseInterceptorHandler handler,
) {
  if (kDebugMode) {
    debugPrint('← ${response.statusCode} ${response.requestOptions.path}');
  }

  handler.next(response);
}

@override
Future<void> onError(
  DioException err,
  ErrorInterceptorHandler handler,
) async {
  if (kDebugMode) {
    debugPrint('✗ ${err.response?.statusCode} ${err.requestOptions.path}');
  }

  if(err.response?.statusCode == 401) {
    // TODO(developer): Handle 401 error - maybe refresh token or logout

   final refreshed = await _tryRefreshToken();
   if(refreshed) {
    // Retry the request with the new token
    final token = await _secureStorage.getAccessToken();
    err.requestOptions.headers['Authorization'] = 'Bearer $token';
    final response = await _dio.fetch(err.requestOptions);
    handler.resolve(response);
    return;
   }
    
    await _secureStorage.clearAll();
  }

  handler.next(err);
}

Future<bool> _tryRefreshToken() async {
  try {
    final refreshToken = await _secureStorage.getRefreshToken();

    if (refreshToken == null) return false;

    final response = await _dio.post(
      ApiEndpoints.refreshToken,
      data: {'refresh_token': refreshToken},
    );

    final newAccessToken = response.data['access_token'] as String;
    await _secureStorage.saveAccessToken(newAccessToken);

    return true;
  } catch (_) {
    return false;
  }
}
}

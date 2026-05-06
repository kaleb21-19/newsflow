import 'package:newsflow/core/error/exceptions.dart';
import 'package:newsflow/core/network/api_client.dart';
import 'package:newsflow/core/network/api_endpoints.dart';
import 'package:newsflow/core/utils/app_config.dart';
import 'package:newsflow/features/auth/data/models/user_model.dart';

/// Abstract class for authentication remote data source
abstract class AuthRemoteDatasource {
  /// Login user with email and password
  Future<UserModel> login({
    required String email,
    required String password,
  });
  
  /// Register user with email and password
  Future<UserModel> register({
    required String email,
    required String password,
  });
}


class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final ApiClient _apiClient;
  
  AuthRemoteDatasourceImpl({required ApiClient apiClient}): _apiClient = apiClient;
  
  @override
  Future<UserModel> login({required String email, required String password}) async{
    final response = await _apiClient.post(
    
      '/login',
      baseUrl: AppConfig.authBaseUrl,
      body: {
        'email': email,
        'password': password,
      },
    );
   final token = response['token'] as String?;

   if (token == null) {
     throw const NetworkException();
   }
   // _apiClient.setToken(token);


    final userResponse = await _apiClient.get(
      ApiEndpoints.user('2'),
      baseUrl: AppConfig.authBaseUrl,
    );
    final userData=  userResponse['data'] as Map<String, dynamic>;

    return UserModel.fromJson({...userData,'token': token});
  }
  
  @override
@override
  Future<UserModel> register({
    required String email,
    required String password,
  }) async {
    // Step 1 — call register endpoint
    final registerResponse = await _apiClient.post(
      ApiEndpoints.register,
      body: {
        'email': email,
        'password': password,
      },
      baseUrl: AppConfig.authBaseUrl,
    );

    // Step 2 — extract id and token
    final token = registerResponse['token'] as String?;
    final id = registerResponse['id']?.toString();

    if (token == null || id == null) {
      throw const ServerException(message: 'Invalid register response');
    }

    // Step 3 — fetch full user data
    final userResponse = await _apiClient.get(
      ApiEndpoints.user(id),
      baseUrl: AppConfig.authBaseUrl,
    );

    // Step 4 — build and return UserModel
    final userData = userResponse['data'] as Map<String, dynamic>;
    return UserModel.fromJson({
      ...userData,
      'token': token,
    });
  }
}

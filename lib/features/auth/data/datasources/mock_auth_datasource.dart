import 'package:newsflow/core/error/exceptions.dart';
import 'package:newsflow/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:newsflow/features/auth/data/models/user_model.dart';

/// Mock implementation of [AuthRemoteDatasource]
/// Used in development — simulates real API behavior
/// with predictable responses and realistic delays
class MockAuthDatasource implements AuthRemoteDatasource {
  // Valid test credentials
  static const _validEmail = 'test@newsflow.com';
  static const _validPassword = 'password123';

  // Fake user returned on success
  static const _fakeUser = UserModel(
    id: '1',
    email: _validEmail,
    firstName: 'John',
    lastName: 'Doe',
    avatar: 'https://i.pravatar.cc/150?img=3',
    token: 'fake_jwt_token_abc123xyz',
  );

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Validate credentials
    if (email != _validEmail || password != _validPassword) {
      throw const ServerException(
        message: 'Invalid email or password',
        statusCode: 401,
      );
    }

    return _fakeUser;
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Simulate email already taken
    if (email == _validEmail) {
      throw const ServerException(
        message: 'Email already registered',
        statusCode: 409,
      );
    }

    // Register any other email successfully
    return UserModel(
      id: '2',
      email: email,
      firstName: 'New',
      lastName: 'User',
      avatar: 'https://i.pravatar.cc/150?img=5',
      token: 'fake_jwt_token_newuser456',
    );
  }
}
import 'package:dartz/dartz.dart';
import 'package:newsflow/core/error/exceptions.dart';
import 'package:newsflow/core/error/failures.dart';
import 'package:newsflow/core/network/network_info.dart';
import 'package:newsflow/core/storage/local_storage.dart';
import 'package:newsflow/core/storage/secure_storage.dart';
import 'package:newsflow/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:newsflow/features/auth/data/models/user_model.dart';
import 'package:newsflow/features/auth/domain/entities/user_entity.dart';
import 'package:newsflow/features/auth/domain/repositories/auth_repository.dart';

/// Implementation of [AuthRepository]
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remoteDatasource;
  final SecureStorage _secureStorage;
  final LocalStorage _localStorage;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl({
    required AuthRemoteDatasource remoteDatasource,
    required SecureStorage secureStorage,
    required LocalStorage localStorage,
    required NetworkInfo networkInfo,
  })  : _remoteDatasource = remoteDatasource,
        _secureStorage = secureStorage,
        _localStorage = localStorage,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      final userModel = await _remoteDatasource.login(
        email: email,
        password: password,
      );

      await _secureStorage.saveAccessToken(userModel.token);
      await _secureStorage.saveUserId(userModel.id);
      await _localStorage.saveUser(userModel.toMap());

      return Right(userModel.toEntity());
    } on NetworkException {
      return const Left(NetworkFailure('No internet connection'));
    } on AuthException {
      return const Left(AuthFailure('Invalid credentials'));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      final userModel = await _remoteDatasource.register(
        email: email,
        password: password,
      );

      await _secureStorage.saveAccessToken(userModel.token);
      await _secureStorage.saveUserId(userModel.id);
      await _localStorage.saveUser(userModel.toMap());

      return Right(userModel.toEntity());
    } on NetworkException {
      return const Left(NetworkFailure('No internet connection'));
    } on AuthException {
      return const Left(AuthFailure('Email already registered'));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _secureStorage.clearAll();
      await _localStorage.clearUser();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final userMap = _localStorage.getUser();

      if (userMap == null) {
        return const Left(AuthFailure('No user logged in'));
      }

      final userModel = UserModel.fromMap(userMap);

      final token = await _secureStorage.getAccessToken();
      if (token == null) {
        return const Left(AuthFailure('No token found'));
      }

      return Right(userModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:newsflow/core/error/failures.dart';
import 'package:newsflow/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  /// Login with email and password
  /// Returns [UserEntity] on success
  /// Returns [Failure] on error
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  /// Register with email and password
  /// Returns [UserEntity] on success
  /// Returns [Failure] on error
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
  });

  /// Logout current user
  /// Clears all stored tokens and user data
  Future<Either<Failure, void>> logout();

  /// Get currently logged in user from local storage
  /// Returns [UserEntity] if logged in
  /// Returns [Failure] if not logged in or data missing
  Future<Either<Failure, UserEntity>> getCurrentUser();
}

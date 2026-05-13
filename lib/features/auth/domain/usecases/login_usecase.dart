
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:newsflow/core/error/failures.dart';
import 'package:newsflow/core/usecases/usecase.dart';
import 'package:newsflow/features/auth/domain/entities/user_entity.dart';
import 'package:newsflow/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase extends UseCase<UserEntity,LoginParam> {
  final AuthRepository _authRepository;

  LoginUsecase(this._authRepository );

  @override
  Future<Either<Failure, UserEntity>> call(LoginParam params) {
      return  _authRepository.login(email: params.email, password: params.password);
  }
}

class LoginParam extends Equatable{
  final String email;
  final String password;

  const LoginParam({
    required this.email,
    required this.password
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [email,password];
}

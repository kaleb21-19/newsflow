import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:newsflow/core/error/failures.dart';
import 'package:newsflow/core/usecases/usecase.dart' show UseCase;
import 'package:newsflow/features/auth/domain/entities/user_entity.dart';
import 'package:newsflow/features/auth/domain/repositories/auth_repository.dart';



class RegisterUseCase extends UseCase<UserEntity, RegisterParams> {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams params) {
    return _repository.register(
      email: params.email,
      password: params.password,
    );
  }
}

class RegisterParams extends Equatable {
  final String email;
  final String password;

  const RegisterParams({
    required this.email,
    required this.password,
  });


  @override
  List<Object> get props => [email, password];
}

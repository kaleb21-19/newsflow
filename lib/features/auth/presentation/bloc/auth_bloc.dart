import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsflow/core/error/failures.dart';
import 'package:newsflow/core/usecases/usecase.dart';
import 'package:newsflow/features/auth/domain/entities/user_entity.dart';
import 'package:newsflow/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:newsflow/features/auth/domain/usecases/login_usecase.dart';
import 'package:newsflow/features/auth/domain/usecases/logout_usecase.dart';
import 'package:newsflow/features/auth/domain/usecases/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  AuthBloc({
    required LoginUsecase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _logoutUseCase = logoutUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase,
        super(const AuthState.initial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onAppStarted(
  AppStarted event,
  Emitter<AuthState> emit,
) async {
  emit(const AuthState.loading());

  final result = await _getCurrentUserUseCase(const NoParams());

  result.fold(
    (failure) => emit(const AuthState.unauthenticated()),
    (user) => emit(AuthState.authenticated(user)),
  );
}

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    final result = await _loginUseCase(
      LoginParam(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthState.error(_mapFailureToMessage(failure))),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    final result = await _registerUseCase(
      RegisterParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthState.error(_mapFailureToMessage(failure))),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    final result = await _logoutUseCase(const NoParams());

    result.fold(
      (failure) => emit(AuthState.error(_mapFailureToMessage(failure))),
      (_) => emit(const AuthState.unauthenticated()),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure) {
      case NetworkFailure():
        return 'No internet connection. Please check your network.';
      case AuthFailure():
        return failure.message;
      case ServerFailure():
        return failure.message;
      case CacheFailure():
        return 'Local storage error. Please restart the app.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}

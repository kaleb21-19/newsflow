part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
  
  @override
  List<Object> get props => [];
}
/// App started — check if user is already logged in
final class AppStarted extends AuthEvent {
  const AppStarted();
}

/// User submitted login form
final class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;

  const LoginSubmitted({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

/// User submitted register form
final class RegisterSubmitted extends AuthEvent {
  final String email;
  final String password;

  const RegisterSubmitted({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

/// User tapped logout
final class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}



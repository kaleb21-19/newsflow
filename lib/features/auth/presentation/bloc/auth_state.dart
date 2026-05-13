part of 'auth_bloc.dart';

enum AuthStatus {
  initial,      // app just opened
  loading,      // checking or waiting
  authenticated,   // logged in
  unauthenticated, // not logged in
  error,        // something went wrong
}
final class AuthState extends Equatable {
  final AuthStatus status;
  final UserEntity? user;
  final String errorMessage;

  const AuthState._({
    required this.status,
    this.user,
    this.errorMessage = '',
  });
  
// App just started
  const AuthState.initial() : this._(status: AuthStatus.initial);

// Something is loading
  const AuthState.loading() : this._(status: AuthStatus.loading);

  // User is logged in
  const AuthState.authenticated(UserEntity user)
      : this._(
          status: AuthStatus.authenticated,
          user: user,
        );

  // User is not logged in
  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  // Something went wrong
  const AuthState.error(String message)
      : this._(
          status: AuthStatus.error,
          errorMessage: message,
        );

        // Convenience getter — is the user logged in?
  bool get isAuthenticated => status == AuthStatus.authenticated;

  @override
  List<Object?> get props => [status, user, errorMessage];

}



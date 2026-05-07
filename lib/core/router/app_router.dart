import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsflow/features/auth/presentation/pages/login_page.dart';
import 'package:newsflow/features/auth/presentation/pages/register_page.dart';
import 'package:newsflow/features/auth/presentation/pages/splash_page.dart';
import 'package:newsflow/features/home/presentation/pages/home_page.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import 'route_names.dart';

class AppRouter {
  AppRouter._();

  static GoRouter router(AuthBloc authBloc) {
    return GoRouter(
      initialLocation: RouteNames.splash,
      debugLogDiagnostics: true,
      
      // Rebuilds router when auth state changes
      refreshListenable: _AuthChangeNotifier(authBloc),
redirect: (context, state) {
  final authState = authBloc.state;
  final location = state.matchedLocation;

  print('Redirect fired — status: ${authState.status}, location: $location');

  // Still checking
  final isInitialOrLoading =
      authState.status == AuthStatus.initial ||
      authState.status == AuthStatus.loading;

  if (isInitialOrLoading) return RouteNames.splash;

  final isAuthenticated =
      authState.status == AuthStatus.authenticated;

  final isOnAuthPage =
      location == RouteNames.login ||
      location == RouteNames.register ||
      location == RouteNames.splash;

  // Logged in on auth page — go home
  if (isAuthenticated && isOnAuthPage) return RouteNames.home;

  // Not logged in on splash — go to login
  if (!isAuthenticated && location == RouteNames.splash) {
    return RouteNames.login;
  }

  // Not logged in on protected page — go to login
  if (!isAuthenticated && !isOnAuthPage) return RouteNames.login;

  return null;
},
      routes: [
        GoRoute(
          path: RouteNames.splash,
          name: 'splash',
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: RouteNames.login,
          name: 'login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: RouteNames.register,
          name: 'register',
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: RouteNames.home,
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
      ],
    );
  }
}



/// Notifies go_router when AuthBloc state changes
/// go_router listens to this and re-runs redirect
class _AuthChangeNotifier extends ChangeNotifier {
  final AuthBloc _authBloc;
  late final StreamSubscription<AuthState> _subscription;

  _AuthChangeNotifier(this._authBloc) {
    _subscription = _authBloc.stream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

}
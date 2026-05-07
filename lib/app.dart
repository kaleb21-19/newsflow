import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsflow/core/di/injection.dart';
import 'package:newsflow/core/router/app_router.dart';
import 'package:newsflow/core/theme/app_theme.dart';
import 'package:newsflow/core/utils/app_config.dart';
import 'package:newsflow/features/auth/presentation/bloc/auth_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => getIt<AuthBloc>(),
      child: const _AppView(),
    );
  }
}
class _AppView extends StatefulWidget {
  const _AppView();

  @override
  State<_AppView> createState() => __AppViewState();
}

class __AppViewState extends State<_AppView> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter.router(getIt<AuthBloc>());
  }

  @override
  Widget build(BuildContext context) {
       return MaterialApp.router(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: AppConfig.isDevelopment,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: _router,
    );
  }
}

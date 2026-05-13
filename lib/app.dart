import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsflow/core/di/injection.dart';
import 'package:newsflow/core/router/app_router.dart';
import 'package:newsflow/core/theme/app_theme.dart';
import 'package:newsflow/core/utils/app_config.dart';
import 'package:newsflow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:newsflow/features/saved/presentation/bloc/saved_bloc.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
      
          // Create AuthBloc at the top of the app
          // Available to every widget including the router
          create: (_) => getIt<AuthBloc>(),
        ),
        BlocProvider<SavedBloc>(
          create: (context) => getIt<SavedBloc>()..add(const LoadSavedArticles()),
        ),
      ],
      child: _AppView(),
    );
  }
}

class _AppView extends StatefulWidget {
  const _AppView();

  @override
  State<_AppView> createState() => _AppViewState();
}

class _AppViewState extends State<_AppView> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    // Create router with AuthBloc
    _router = AppRouter.router(context.read<AuthBloc>());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: AppConfig.isProduction,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: _router,
    );
  }
}

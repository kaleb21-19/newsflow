import 'package:flutter/material.dart';
import 'package:newsflow/core/utils/app_config.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      home: Scaffold(
        body: Center(
      child: Text(
            'Running: ${AppConfig.environment.name}',
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

}

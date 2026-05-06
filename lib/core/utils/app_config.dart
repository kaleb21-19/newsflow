
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Environment { development, production }

class AppConfig {
  AppConfig._();

  static Environment get environment {
    final env = dotenv.env['ENVIRONMENT'] ?? 'development';
    return env == 'production' ? Environment.production : Environment.development;
  }


  static String get appName =>
      dotenv.env['APP_NAME'] ?? 'NewsFlow';
  
  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? '';

  static String get authBaseUrl =>
      dotenv.env['AUTH_BASE_URL'] ?? '';
  
  static String get apiKey =>
      dotenv.env['API_KEY'] ?? '';

  static bool get isDevelopment =>
      environment == Environment.development;

  static bool get isProduction =>
      environment == Environment.production;
}
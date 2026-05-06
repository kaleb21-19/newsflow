class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';

  // News
  static const String topHeadlines = '/top-headlines';
  static const String everything = '/everything';
  static const String sources = '/top-headlines/sources';
}

class ApiEndpoints {
  ApiEndpoints._();


  static const String refreshToken = '/auth/refresh';

  // Auth — reqres.in
  static const String login = '/login';
  static const String register = '/register';
  static String user(String id) => '/user/$id';

  // News — newsapi.org
  static const String topHeadlines = '/top-headlines';
  static const String everything = '/everything';
  static const String sources = '/top-headlines/sources';
}

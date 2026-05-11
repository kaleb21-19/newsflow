/// All route paths in one place.
/// Never write a path string anywhere else.
class RouteNames {
  RouteNames._();

  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  //static const String articleDetail = '/article/:id';

  // Helper for article detail with actual id
  //static String article(String id) => '/article/$id';
  static const String articleDetail = '/article';
}

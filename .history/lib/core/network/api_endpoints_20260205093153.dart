/// Centralized API endpoint constants
/// All API endpoints should be defined here for better maintainability
class ApiEndpoints {
  // Prevent instantiation
  ApiEndpoints._();

  // Base path
  static const String _auth = '/auth';
  static const String _users = '/users';
  static const String _products = '/products';
  static const String _orders = '/orders';
  static const String _categories = '/categories';

  // Auth Endpoints
  static const String login = '$_auth/login';
  static const String register = '$_auth/register';
  static const String logout = '$_auth/logout';
  static const String refresh = '$_auth/refresh';
  static const String forgotPassword = '$_auth/forgot-password';
  static const String resetPassword = '$_auth/reset-password';
  static const String changePassword = '$_auth/change-password';
  static const String verifyEmail = '$_auth/verify-email';

  // User Endpoints
  static const String userProfile = '$_users/profile';
  static const String updateUserProfile = '$_users/profile';
  static const String userAvatar = '$_users/avatar';
  static const String deleteUser = '$_users/:id';
  static String getUserById(String id) => '$_users/$id';

  // Product Endpoints
  static const String products = '$_products';
  static String productById(String id) => '$_products/$id';
  static const String searchProducts = '$_products/search';
  static String productByCategory(String categoryId) => '$_products/category/$categoryId';

  // Order Endpoints
  static const String orders = '$_orders';
  static String orderById(String id) => '$_orders/$id';
  static String cancelOrder(String id) => '$_orders/$id/cancel';
  static const String myOrders = '$_orders/my';

  // Category Endpoints
  static const String categories = '$_categories';
  static String categoryById(String id) => '$_categories/$id';

  // Format endpoint with parameters
  static String format(String endpoint, Map<String, String> params) {
    String formatted = endpoint;
    params.forEach((key, value) {
      formatted = formatted.replaceFirst(':$key', value);
    });
    return formatted;
  }
}

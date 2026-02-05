/// Centralized API endpoint constants
/// All API endpoints should be defined here for better maintainability
class ApiEndpoints {
  // Prevent instantiation
  ApiEndpoints._();

  // Base path
  static const String _auth = '/auth';

  // Auth Endpoints
  static const String login = '$_auth/login';

  // User Endpoints
  // static const String userProfile = '$_users/profile';
  // static const String updateUserProfile = '$_users/profile';
  // static const String userAvatar = '$_users/avatar';
  // static const String deleteUser = '$_users/:id';
  // static String getUserById(String id) => '$_users/$id';

  // :: Format endpoint with parameters
  static String format(String endpoint, Map<String, String> params) {
    String formatted = endpoint;
    params.forEach((key, value) {
      formatted = formatted.replaceFirst(':$key', value);
    });
    return formatted;
  }
}

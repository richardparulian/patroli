/// Centralized API endpoint constants
/// All API endpoints should be defined here for better maintainability
class ApiEndpoints {
  // Prevent instantiation
  ApiEndpoints._();

  // Version endpoint
  static const String _version = '/api/v1';

  // Base path
  static const String _auth = '$_version/auth';

  // Auth Endpoints
  static const String login = '$_auth/login';

  // Visit Endpoints

  static const String _visits = '$_version/mobile/visits';
  static const String visitCreate = '$_visits/create';
  static const String visitDetails = '$_visits/:id/detail';

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

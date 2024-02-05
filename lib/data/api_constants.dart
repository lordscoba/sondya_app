//  hosted base url
const String baseUrl = 'https://sondya-backend.adaptable.app/api/v1';
const String wsBaseUrl = 'wss://sondya-backend.adaptable.app/api/v1';

// local base url

// static const String baseUrl = 'http://localhost:8989/api/v1';
// static const String wsBaseUrl = 'ws://localhost:8989/api/v1';

class EnvironmentAuthConfig {
  // authentication
  static const String login = '$baseUrl/login'; // POST
  static const String register = '$baseUrl/register'; // POST
  static const String forgotPassword = '$baseUrl/forgot-password'; // POST
  static const String resetPassword = '$baseUrl/reset-password/'; // POST :email
  static const String verifyEmail = '$baseUrl/verify-email/'; // POST :email
}

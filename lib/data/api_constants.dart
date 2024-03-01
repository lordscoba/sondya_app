//  hosted base url
// const String baseUrl = 'https://sondya-backend.adaptable.app/api/v1';
// const String wsBaseUrl = 'wss://sondya-backend.adaptable.app/api/v1';

// local base url

const String baseUrl = 'http://localhost:8989/api/v1';
const String wsBaseUrl = 'ws://localhost:8989/api/v1';

// const String baseUrl = 'http://10.0.2.2:8989/api/v1';
// const String wsBaseUrl = 'ws://10.0.2.2:8989/api/v1';

class EnvironmentAuthConfig {
  // authentication
  static const String login = '$baseUrl/login'; // POST
  static const String register = '$baseUrl/register/'; // POST
  static const String forgotPassword = '$baseUrl/forgot-password'; // POST
  static const String resetPassword = '$baseUrl/reset-password/'; // POST :email
  static const String verifyEmail = '$baseUrl/verify-email/'; // POST :email
}

class EnvironmentHomeConfig {
  static const String productDetail =
      '$baseUrl/product/details/'; // GET /:id/:slug(name)
  static const String serviceDetail =
      '$baseUrl/service/details/'; // GET /:id/:slug(name)
  static const String services = '$baseUrl/services'; // GET
  static const String products = '$baseUrl/products'; // GET
  static const String servicesCategory = '$baseUrl/services/categories'; // GET
  static const String productsCategory = '$baseUrl/products/categories'; // GET
}

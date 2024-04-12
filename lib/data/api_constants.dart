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

  // for the search
  static const String productsSearch = '$baseUrl/user/products'; // GET
  static const String servicesSearch = '$baseUrl/user/services'; // GET

  // for reviews

  static const String createReview = '$baseUrl/user/review'; // POST
  static const String getReviewStat =
      '$baseUrl/user/review/stat/'; // GET: :category/:id
  static const String listReviews =
      '$baseUrl/user/review/list/'; // GET: :category/:id
}

class EnvironmentKycConfig {
  static const String kycVerifyEmail =
      '$baseUrl/api/v1/kyc/verify/email'; // POST

  static const String kycVerifyCode =
      '$baseUrl/api/v1/kyc/verify/code/'; // PUT :id - user id

  static const String kycPersonalDetails =
      '$baseUrl/api/v1/kyc/personal/'; // PUT :id - user id

  static const String kycContactInfo =
      '$baseUrl/api/v1/kyc/contact/'; // PUT :id - user id

  static const String kycCompanyDetails =
      '$baseUrl/api/v1/kyc/company/'; // PUT :id - user id

  static const String kycDocumentUpload =
      '$baseUrl/api/v1/kyc/document/'; // PUT :id - user id

  static const String kycProfilePicture =
      '$baseUrl/api/v1/kyc/image/'; // PUT :id - user id
}

class EnvironmentProfileConfig {
  // /api/v1/profile/user/{id}

  static const String getUsers = '$baseUrl/api/v1/profile/users'; // GET

  static const String getUserById =
      '$baseUrl/api/v1/profile/user/'; // GET :id - user id

  static const String updateProfileById =
      '$baseUrl/api/v1/profile/update/'; // PUT :id - user id

  static const String updatePassword =
      '$baseUrl/api/v1/profile/update/password/'; // PUT :id - user id

  static const String updateSocials =
      '$baseUrl/api/v1/profile/update/socials/'; // PUT :id - user id

  static const String updateCompany =
      '$baseUrl/api/v1/profile/update/company/'; // PUT :id - user id
}

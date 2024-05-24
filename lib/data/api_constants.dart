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

  static const String productPrice = '$baseUrl/product/price/'; // GET /:id/

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
  static const String kycVerifyEmail = '$baseUrl/kyc/verify/email'; // POST

  static const String kycVerifyCode =
      '$baseUrl/kyc/verify/code/'; // PUT :id - user id

  static const String kycPersonalDetails =
      '$baseUrl/kyc/personal/'; // PUT :id - user id

  static const String kycContactInfo =
      '$baseUrl/kyc/contact/'; // PUT :id - user id

  static const String kycCompanyDetails =
      '$baseUrl/kyc/company/'; // PUT :id - user id

  static const String kycDocumentUpload =
      '$baseUrl/kyc/document/'; // PUT :id - user id

  static const String kycProfilePicture =
      '$baseUrl/kyc/image/'; // PUT :id - user id
}

class EnvironmentProfileConfig {
  static const String getUsers = '$baseUrl/profile/users'; // GET

  static const String getUserById =
      '$baseUrl/profile/user/'; // GET :id - user id

  static const String updateProfileById =
      '$baseUrl/profile/update/'; // PUT :id - user id

  static const String updatePassword =
      '$baseUrl/profile/update/password/'; // PUT :id - user id

  static const String updateSocials =
      '$baseUrl/profile/update/socials/'; // PUT :id - user id

  static const String updateCompany =
      '$baseUrl/profile/update/company/'; // PUT :id - user id
}

class EnvironmentUserPaymentConfig {
  // payment verification
  static const String getUserPayments =
      '$baseUrl/user/payments/'; // GET :user_id
  static const String getUserPaymentsById =
      '$baseUrl/user/payments/details/'; // GET :id
  static const String initializePayment = '$baseUrl/user/payments/pay';
  static const String verifyPayment =
      '$baseUrl/user/payments/verify/'; // GET :tx_ref
}

class EnvironmentServiceCheckoutConfig {}

class EnvironmentUserProductOrderConfig {
  static const String productOrder =
      '$baseUrl/user/order/products/create'; // POST

  static const String getproductOrders =
      '$baseUrl/user/order/products/'; // GET :userId - user id

  static const String getproductOrdersById =
      '$baseUrl/user/order/products/details/'; // GET :id - order id
}

class EnvironmentUserServiceOrderConfig {
  static const String createServiceOrder =
      '$baseUrl/user/order/services/create/'; // POST :service_id
  static const String getServiceOrderById =
      '$baseUrl/user/order/services/'; // GET: order_id
  static const String getUserServiceOrders =
      '$baseUrl/user/order/services/list/'; // GET: buyer_id
  static const String updateTerms =
      '$baseUrl/user/order/services/updateterms/'; // PUT: order_id
  static const String updateServiceOrder =
      '$baseUrl/user/order/services/update/'; // PUT: order_id
}

class EnvironmentTrackOrderConfig {
  static const String getTracking =
      '$baseUrl/user/order/products/details/byorderid/'; // GET :order_id
}

class EnvironmentSellerProductConfig {
  static const String create = '$baseUrl/seller/product/create'; // POST
  static const String update = '$baseUrl/seller/product/update/'; // PUT :id
  static const String delete = '$baseUrl/seller/product/'; // DELETE :id
  static const String getByID = '$baseUrl/seller/product/'; // GET :id
  static const String getAll = '$baseUrl/seller/products/'; // GET :userId
}

class EnvironmentSellerServiceConfig {
  static const String create = '$baseUrl/seller/service/create'; // POST
  static const String update = '$baseUrl/seller/service/update/'; // PUT :id
  static const String delete = '$baseUrl/seller/service/'; // DELETE :id
  static const String getByID = '$baseUrl/seller/service/'; // GET :id
  static const String getAll = '$baseUrl/seller/services/'; // GET :userId
}

class EnvironmentSellerProductOrderConfig {
  static const String getProductsOrders =
      '$baseUrl/seller/order/products/'; // GET :user_id
  static const String getProductOrdersById =
      '$baseUrl/seller/order/product/details/'; // GET :id
  static const String updateProductOrders =
      '$baseUrl/seller/order/products/update'; // PUT :getProductOrder Type
  static const String deleteProductOrdersById =
      '$baseUrl/seller/order/products/'; // GET :id
}

class EnvironmentSellerServiceOrderConfig {
  static const String getSellerServiceOrders =
      '$baseUrl/seller/order/services/list/'; // GET: seller_id
  static const String getSellerServiceOrderById =
      '$baseUrl/seller/order/services/'; // GET: order_id + seller
  static const String updateSellerTerms =
      '$baseUrl/seller/order/services/updateterms/'; // PUT: order_id + seller
  static const String updateSellerServiceOrder =
      '$baseUrl/seller/order/services/update/'; // PUT: order_id  + seller
}

class EnvironmentSellerAccountConfig {
  static const String getBalance =
      '$baseUrl/account/balance/'; // GET :id  - user's id
  static const String addBankAccount =
      '$baseUrl/account/bank/add/'; // PUT :id - user's id
  static const String deleteBankAccount =
      '$baseUrl/account/bank/delete/'; // DELETE :userId - user's id /:id - bank's id
  static const String addPayPalAccount =
      '$baseUrl/account/paypal/add/'; // PUT :id - user's id
  static const String deletePayPalAccount =
      '$baseUrl/account/paypal/delete/'; // DELETE :userId - user's id /:id - paypal's id
  static const String addPayoneerAccount =
      '$baseUrl/account/payoneer/add/'; // PUT :id - user's id
  static const String deletePayoneerAccount =
      '$baseUrl/account/payoneer/delete/'; // DELETE :userId - user's id /:id - payoneer's id
}

class EnvironmentSellerWithdrawalConfig {
  static const String withdraw = '$baseUrl/seller/withdraw'; // POST
  static const String getWithdrawals =
      '$baseUrl/seller/withdrawals/'; // GET :id - user's id
  static const String getWithdrawalById =
      '$baseUrl/seller/withdrawal/details/'; // GET :id - withdrawal's id
  static const String getWithdrawalStat =
      '$baseUrl/seller/withdrawal/stat/'; // GET :id - user's id
  static const String deleteWithdrawal =
      '$baseUrl/seller/withdrawal/delete/'; // DELETE :id - withdrawal's id
}

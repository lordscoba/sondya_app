// GoRouter configuration
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/domain/providers/auth.provider.dart';
import 'package:sondya_app/presentation/pages/auth/forgot_password_screen.dart';
import 'package:sondya_app/presentation/pages/auth/login_screen.dart';
import 'package:sondya_app/presentation/pages/auth/register_screen.dart';
import 'package:sondya_app/presentation/pages/auth/register_success_screen.dart';
import 'package:sondya_app/presentation/pages/auth/reset_password_screen.dart';
import 'package:sondya_app/presentation/pages/auth/verification_code_screen.dart';
import 'package:sondya_app/presentation/pages/cart_screen.dart';
import 'package:sondya_app/presentation/pages/error_screen.dart';
import 'package:sondya_app/presentation/pages/groupchat_details.dart';
import 'package:sondya_app/presentation/pages/groupchat_list_screen.dart';
import 'package:sondya_app/presentation/pages/groupchat_screen.dart';
import 'package:sondya_app/presentation/pages/home_screen.dart';
import 'package:sondya_app/presentation/pages/notifications_screen.dart';
import 'package:sondya_app/presentation/pages/onboarding_screen.dart';
import 'package:sondya_app/presentation/pages/product_checkout_confirmation_screen.dart';
import 'package:sondya_app/presentation/pages/product_checkout_screen.dart';
import 'package:sondya_app/presentation/pages/product_checkout_status_screen.dart';
import 'package:sondya_app/presentation/pages/product_details_screen.dart';
import 'package:sondya_app/presentation/pages/product_search_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_add_account_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_inbox_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_order_deliver_work_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_order_review_terms_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_order_update_location_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_order_update_status_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_products_add_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_products_details_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_products_edit_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_products_orders_details_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_products_orders_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_products_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_products_status_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_services_add_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_services_details_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_services_edit_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_services_orders_details_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_services_orders_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_services_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_services_status_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_withdraw_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_withdrawal_details_screen.dart';
import 'package:sondya_app/presentation/pages/sellerDashboard/seller_withdrawals_screen.dart';
import 'package:sondya_app/presentation/pages/service_checkout_confirmation_screen.dart';
import 'package:sondya_app/presentation/pages/service_checkout_screen.dart';
import 'package:sondya_app/presentation/pages/service_checkout_status_screen.dart';
import 'package:sondya_app/presentation/pages/service_details_screen.dart';
import 'package:sondya_app/presentation/pages/service_search_screen.dart';
import 'package:sondya_app/presentation/pages/splash_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/inbox_chat_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/inbox_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/kyc_code_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/kyc_company_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/kyc_contact_info.dart';
import 'package:sondya_app/presentation/pages/userDashboard/kyc_document_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/kyc_dp_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/kyc_email_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/kyc_personal_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/product_order_details_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/product_order_history_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/product_order_review_terms_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/referral_sceen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/service_order_details_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/service_order_history_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/settings_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/theme_mode_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/track_order_details_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/track_order_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/user_payments_details_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/user_payments_screen.dart';
import 'package:sondya_app/presentation/pages/welcome_screen.dart';
import 'package:sondya_app/presentation/pages/wishlist_screen.dart';
import 'package:sondya_app/utils/auth_utils.dart';
import 'package:sondya_app/utils/has_initialized_app.dart';

GoRouter goRouterFunc(WidgetRef ref) {
  FutureOr<String?> paymentDoneRedirectStrict(
      BuildContext context, GoRouterState state) async {
    final isAuth = await isAuthenticated();
    if (!isAuth) {
      ref.watch(isAuthenticatedTemp.notifier).state = false;
      return '/login';
    }
    ref.watch(isAuthenticatedTemp.notifier).state = true;
    return null;
  }

  FutureOr<String?> authRedirectStrict(
      BuildContext context, GoRouterState state) async {
    final isAuth = await isAuthenticated();
    if (!isAuth) {
      ref.watch(isAuthenticatedTemp.notifier).state = false;
      return '/login';
    }
    ref.watch(isAuthenticatedTemp.notifier).state = true;
    return null;
  }

  FutureOr<String?> authRedirectStrictSeller(
      BuildContext context, GoRouterState state) async {
    final isAuth = await isAuthenticated();
    final isKyc = await isKycCompleted();

    if (!isAuth) {
      ref.watch(isAuthenticatedTemp.notifier).state = false;
      return '/login';
    }

    if (!isKyc) {
      return '/kyc/email/verify';
    }

    ref.watch(isAuthenticatedTemp.notifier).state = true;
    return null;
  }

  FutureOr<String?> authRedirectAuthPage(
      BuildContext context, GoRouterState state) async {
    final isAuth = await isAuthenticated();
    if (isAuth) {
      ref.watch(isAuthenticatedTemp.notifier).state = true;
      return '/';
    }
    ref.watch(isAuthenticatedTemp.notifier).state = false;
    return null;
  }

  return GoRouter(
    // initialLocation: "/inbox",
    // initialLocation:
    //     "/inbox/chat/65a11540df8051503766b73f/65392eefb7498d248b07c91b",
    // initialLocation: "/group/chat/list",
    // initialLocation: "/group/chat/656dca98138f07e0f17648f9",
    // initialLocation: "/group/chat/details/656dca98138f07e0f17648f9",
    initialLocation: hasInitializedAppSession() ? '/' : "/splash",
    errorBuilder: (context, state) => const ErrorScreen(),
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/product/search',
        builder: (context, state) {
          return const ProductSearchScreen();
        },
      ),
      GoRoute(
        path: '/service/search',
        builder: (context, state) {
          return const ServiceSearchScreen();
        },
      ),
      GoRoute(
        path: '/product/details/:id/:name',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final name = state.pathParameters['name']!;
          return ProductDetailsScreen(
            id: id,
            name: name,
          );
        },
      ),
      GoRoute(
        path: '/service/details/:id/:name',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final name = state.pathParameters['name']!;
          return ServiceDetailsScreen(
            id: id,
            name: name,
          );
        },
        redirect: authRedirectStrict,
      ),

      // Auth routes
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
        redirect: authRedirectAuthPage,
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
        redirect: authRedirectAuthPage,
      ),
      GoRoute(
        path: '/forgotPassword',
        builder: (context, state) => const ForgotPasswordScreen(),
        redirect: authRedirectAuthPage,
      ),
      GoRoute(
        path: '/resetPassword/:email',
        builder: (context, state) {
          final email = state.pathParameters['email']!;
          return ResetPasswordScreen(email: email);
        },
        redirect: authRedirectAuthPage,
      ),
      GoRoute(
        path: '/verificationCode/:email',
        builder: (context, state) {
          final email = state.pathParameters['email']!;
          return VerificationCodeScreen(email: email);
        },
        redirect: authRedirectAuthPage,
      ),
      GoRoute(
        path: '/registerSuccess',
        builder: (context, state) => const RegisterSuccessScreen(),
        redirect: authRedirectAuthPage,
      ),

      // settings route
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/referral',
        builder: (context, state) => const ReferralPageScreen(),
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/inbox',
        builder: (context, state) => const InboxScreen(),
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/inbox/chat/:receiver_id/:user_id',
        builder: (context, state) {
          final receiverId = state.pathParameters['receiver_id']!;
          final userId = state.pathParameters['user_id']!;
          final extra = state.extra! as Map<String, dynamic>;
          return InboxChatScreen(
              receiverId: receiverId, userId: userId, data: extra);
        },
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/theme/mode',
        builder: (context, state) => const ThemeModeScreen(),
        redirect: authRedirectStrict,
      ),

      // kyc settings route
      GoRoute(
        path: '/kyc/email/verify',
        builder: (context, state) => const KycEmailVerificationScreen(),
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/kyc/code/verify',
        builder: (context, state) => const KycCodeScreenVerification(),
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/kyc/personal/information',
        builder: (context, state) => const KycPersonalInformationScreen(),
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/kyc/contact/info',
        builder: (context, state) => const KycContactInfoScreen(),
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/kyc/document/upload',
        builder: (context, state) => const KycDocumentUploadScreen(),
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/kyc/profile/pics',
        builder: (context, state) => const KycProfilePicsScreen(),
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/kyc/company/information',
        builder: (context, state) => const KycCompanyInformationScreen(),
        redirect: authRedirectStrict,
      ),

      // cart route
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartScreen(),
      ),

      // product checkout route
      GoRoute(
        path: '/product/checkout',
        builder: (context, state) => const ProductCheckoutScreen(),
        redirect: paymentDoneRedirectStrict,
      ),

      // product checkout confirmation route
      GoRoute(
        path: '/product/checkout/confirmation',
        builder: (context, state) => const ProductCheckoutConfirmationScreen(),
        redirect: paymentDoneRedirectStrict,
      ),

      // product checkout status route
      GoRoute(
        path: '/product/checkout/status',
        builder: (context, state) {
          return const ProductCheckoutStatusScreen();
        },
        redirect: authRedirectStrict,
      ),

      // service checkout confirmation route
      GoRoute(
        path: '/service/checkout/confirmation',
        builder: (context, state) {
          final extra = state.extra! as Map<String, dynamic>;
          return ServiceCheckoutConfirmationScreen(data: extra);
        },
        redirect: authRedirectStrict,
      ),

      // service checkout route
      GoRoute(
        path: '/service/checkout/:seller_id/:service_id',
        builder: (context, state) {
          final sellerId = state.pathParameters['seller_id']!;
          final serviceId = state.pathParameters['service_id']!;
          return ServiceCheckoutScreen(
            sellerId: sellerId,
            serviceId: serviceId,
          );
        },
        redirect: authRedirectStrict,
      ),

      // service checkout status route
      GoRoute(
        path: '/service/checkout/status',
        builder: (context, state) {
          final extra = state.extra! as Map<String, dynamic>;
          return ServiceCheckoutStatusScreen(
            data: extra,
          );
        },
        redirect: authRedirectStrict,
      ),

      // wishlist route
      GoRoute(
        path: '/wishlist',
        builder: (context, state) => const WishlistScreen(),
        redirect: authRedirectStrict,
      ),

      // user payments route
      GoRoute(
        path: '/user/payments',
        builder: (context, state) => const UserPaymentsScreen(),
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/user/payment/details/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return UserPaymentDetailsScreen(
            id: id,
          );
        },
        redirect: authRedirectStrict,
      ),

      // order route
      GoRoute(
        path: '/product/order/history',
        builder: (context, state) => const ProductOrderHistoryScreen(),
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/product/order/details/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final extra = state.extra! as Map<String, dynamic>;
          return ProductOrderDetailsScreen(
            id: id,
            data: extra,
          );
        },
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/service/order/history',
        builder: (context, state) => const ServiceOrderHistoryScreen(),
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/service/order/details/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final extra = state.extra! as Map<String, dynamic>;
          return ServiceOrderDetailsScreen(
            id: id,
            data: extra,
          );
        },
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/user/service/order/review/terms/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return UserOrderReviewTermsScreen(
            id: id,
          );
        },
        redirect: authRedirectStrict,
      ),
      // track route
      GoRoute(
        path: '/track/order',
        builder: (context, state) => const TrackOrderScreen(),
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/track/details/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return TrackOrderDetailsScreen(
            id: id,
          );
        },
        redirect: authRedirectStrict,
      ),

      // Group chat route
      GoRoute(
        path: '/group/chat/list',
        builder: (context, state) => const GroupChatListScreen(),
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/group/chat/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return GroupChatScreen(
            groupId: id,
          );
        },
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/group/chat/details/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final extra = state.extra! as Map<String, dynamic>;
          return GroupChatDetailsScreen(
            groupId: id,
            data: extra,
          );
        },
        redirect: authRedirectStrict,
      ),

      // seller inbox
      GoRoute(
        path: '/seller/inbox',
        builder: (context, state) => const SellerInboxScreen(),
        redirect: authRedirectStrictSeller,
      ),

      // seller product route
      GoRoute(
        path: '/seller/products',
        builder: (context, state) => const SellerProductsScreen(),
        redirect: authRedirectStrictSeller,
      ),
      GoRoute(
        path: '/seller/products/details/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final extra = state.extra! as Map<String, dynamic>;
          return SellerProductsDetailsScreen(
            id: id,
            data: extra,
          );
        },
        redirect: authRedirectStrictSeller,
      ),
      GoRoute(
        path: '/seller/products/edit/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return SellerProductsEditScreen(
            id: id,
          );
        },
        redirect: authRedirectStrictSeller,
      ),
      GoRoute(
        path: '/seller/products/add',
        builder: (context, state) => const SellerProductsAddScreen(),
        redirect: authRedirectStrictSeller,
      ),
      GoRoute(
        path: '/seller/products/status',
        builder: (context, state) => const SellerProductsStatusScreen(),
        redirect: authRedirectStrictSeller,
      ),

      // seller services route
      GoRoute(
        path: '/seller/services',
        builder: (context, state) => const SellerServicesScreen(),
        redirect: authRedirectStrictSeller,
      ),
      GoRoute(
        path: '/seller/services/details/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final extra = state.extra! as Map<String, dynamic>;
          return SellerServicesDetailsScreen(
            id: id,
            data: extra,
          );
        },
        redirect: authRedirectStrictSeller,
      ),
      GoRoute(
        path: '/seller/services/edit/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return SellerServicesEditScreen(
            id: id,
          );
        },
        redirect: authRedirectStrictSeller,
      ),
      GoRoute(
        path: '/seller/services/add',
        builder: (context, state) => const SellerServicesAddScreen(),
        redirect: authRedirectStrictSeller,
      ),
      GoRoute(
        path: '/seller/services/status',
        builder: (context, state) => const SellerServicesStatusScreen(),
        redirect: authRedirectStrictSeller,
      ),

      // seller product  order route
      GoRoute(
        path: '/seller/products/orders',
        builder: (context, state) => const SellerProductsOrdersScreen(),
        redirect: authRedirectStrictSeller,
      ),
      GoRoute(
        path: '/seller/products/orders/details/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final extra = state.extra! as Map<String, dynamic>;
          return SellerProductsOrdersDetailsScreen(
            id: id,
            data: extra,
          );
        },
        redirect: authRedirectStrictSeller,
      ),
      GoRoute(
        path: '/seller/order/update/location/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return SellerOrderUpdateLocationScreen(
            id: id,
          );
        },
        redirect: authRedirectStrictSeller,
      ),
      GoRoute(
        path: '/seller/order/update/status/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return SellerOrderUpdateStatusScreen(
            id: id,
          );
        },
        redirect: authRedirectStrictSeller,
      ),

      // seller services  order route
      GoRoute(
        path: '/seller/services/orders',
        builder: (context, state) => const SellerServicesOrdersScreen(),
        redirect: authRedirectStrictSeller,
      ),
      GoRoute(
        path: '/seller/services/orders/details/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final extra = state.extra! as Map<String, dynamic>;
          return SellerServicesOrdersDetailsScreen(
            id: id,
            data: extra,
          );
        },
        redirect: authRedirectStrictSeller,
      ),
      GoRoute(
        path: '/seller/order/review/terms/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return SellerOrderReviewTermsScreen(
            id: id,
          );
        },
        redirect: authRedirectStrictSeller,
      ),
      GoRoute(
        path: '/seller/order/deliver/work/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return SellerOrderDeliverWorkScreen(
            id: id,
          );
        },
        redirect: authRedirectStrictSeller,
      ),

      // seller withdrawal route
      GoRoute(
        path: '/seller/withdrawals',
        builder: (context, state) => const SellerWithdrawalsScreen(),
        redirect: authRedirectStrictSeller,
      ),
      GoRoute(
        path: '/seller/add/account',
        builder: (context, state) => const SellerAddAccountScreen(),
        redirect: authRedirectStrictSeller,
      ),
      GoRoute(
        path: '/seller/withdraw',
        builder: (context, state) => const SellerWithdrawScreen(),
        redirect: authRedirectStrictSeller,
      ),
      GoRoute(
        path: '/seller/withdrawal/details/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return SellerWithdrawalDetailsScreen(
            id: id,
          );
        },
        redirect: authRedirectStrictSeller,
      ),
    ],
  );
}

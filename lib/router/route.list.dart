// GoRouter configuration
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/domain/providers/checkout.provider.dart';
import 'package:sondya_app/presentation/pages/auth/forgot_password_screen.dart';
import 'package:sondya_app/presentation/pages/auth/login_screen.dart';
import 'package:sondya_app/presentation/pages/auth/register_screen.dart';
import 'package:sondya_app/presentation/pages/auth/register_success_screen.dart';
import 'package:sondya_app/presentation/pages/auth/reset_password_screen.dart';
import 'package:sondya_app/presentation/pages/auth/verification_code_screen.dart';
import 'package:sondya_app/presentation/pages/cart_screen.dart';
import 'package:sondya_app/presentation/pages/error_screen.dart';
import 'package:sondya_app/presentation/pages/home_screen.dart';
import 'package:sondya_app/presentation/pages/onboarding_screen.dart';
import 'package:sondya_app/presentation/pages/product_checkout_screen.dart';
import 'package:sondya_app/presentation/pages/product_checkout_status_screen.dart';
import 'package:sondya_app/presentation/pages/product_details_screen.dart';
import 'package:sondya_app/presentation/pages/product_search_screen.dart';
import 'package:sondya_app/presentation/pages/service_checkout_screen.dart';
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
import 'package:sondya_app/presentation/pages/userDashboard/referral_sceen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/service_order_details_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/settings_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/track_order_details_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/track_order_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/user_payments_details_screen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/user_payments_screen.dart';
import 'package:sondya_app/presentation/pages/welcome_screen.dart';
import 'package:sondya_app/presentation/pages/wishlist_screen.dart';
import 'package:sondya_app/utils/auth_utils.dart';

// final GoRouter router = GoRouter1();

GoRouter goRouterFunc(WidgetRef ref) {
  FutureOr<String?> paymentDoneRedirectStrict(
      BuildContext context, GoRouterState state) async {
    if (!isAuthenticated()) {
      return '/login';
    }
    if (ref.watch(ispaymentDone.notifier).state == true) {
      return '/product/checkout/status';
    }
    return null;
  }

  FutureOr<String?> authRedirectStrict(
      BuildContext context, GoRouterState state) async {
    if (!isAuthenticated()) {
      return '/login';
    } else {
      return null;
    }
  }

  return GoRouter(
    initialLocation: '/service/order/details',
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
        builder: (context, state) => const ProductSearchScreen(),
      ),
      GoRoute(
        path: '/service/search',
        builder: (context, state) => const ServiceSearchScreen(),
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
      ),

      // Auth routes
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: '/forgotPassword',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      GoRoute(
        path: '/resetPassword/:email',
        builder: (context, state) {
          final email = state.pathParameters['email']!;
          return ResetPasswordScreen(email: email);
        },
      ),

      GoRoute(
        path: '/verificationCode/:email',
        builder: (context, state) {
          final email = state.pathParameters['email']!;
          return VerificationCodeScreen(email: email);
        },
      ),

      GoRoute(
        path: '/registerSuccess',
        builder: (context, state) => const RegisterSuccessScreen(),
      ),

      // settings route
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
        path: '/inbox/chat',
        builder: (context, state) => const InboxChatScreen(),
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

      // service checkout route
      GoRoute(
        path: '/service/checkout',
        builder: (context, state) => const ServiceCheckoutScreen(),
        redirect: authRedirectStrict,
      ),

      // service checkout route
      GoRoute(
        path: '/product/checkout/status',
        builder: (context, state) => const ProductCheckoutStatusScreen(),
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
        path: '/user/payment/details',
        builder: (context, state) => const UserPaymentDetailsScreen(),
        redirect: authRedirectStrict,
      ),

      // order route
      GoRoute(
        path: '/product/order/history',
        builder: (context, state) => const ProductOrderHistoryScreen(),
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/product/order/details',
        builder: (context, state) => const ProductOrderDetailsScreen(),
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/service/order/history',
        builder: (context, state) => const ProductOrderHistoryScreen(),
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/service/order/details',
        builder: (context, state) => const ServiceOrderDetailsScreen(),
        redirect: authRedirectStrict,
      ),

      // track route
      GoRoute(
        path: '/track/order',
        builder: (context, state) => const TrackOrderScreen(),
        redirect: authRedirectStrict,
      ),
      GoRoute(
        path: '/track/details',
        builder: (context, state) => const TrackOrderDetailsScreen(),
        redirect: authRedirectStrict,
      ),
    ],
  );
}

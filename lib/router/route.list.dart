// GoRouter configuration
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/pages/auth/forgot_password_screen.dart';
import 'package:sondya_app/presentation/pages/auth/login_screen.dart';
import 'package:sondya_app/presentation/pages/auth/register_screen.dart';
import 'package:sondya_app/presentation/pages/auth/register_success_screen.dart';
import 'package:sondya_app/presentation/pages/auth/reset_password_screen.dart';
import 'package:sondya_app/presentation/pages/auth/verification_code_screen.dart';
import 'package:sondya_app/presentation/pages/error_screen.dart';
import 'package:sondya_app/presentation/pages/home_screen.dart';
import 'package:sondya_app/presentation/pages/onboarding_screen.dart';
import 'package:sondya_app/presentation/pages/product_details_screen.dart';
import 'package:sondya_app/presentation/pages/product_search_screen.dart';
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
import 'package:sondya_app/presentation/pages/userDashboard/referral_sceen.dart';
import 'package:sondya_app/presentation/pages/userDashboard/settings_screen.dart';
import 'package:sondya_app/presentation/pages/welcome_screen.dart';

final GoRouter router = GoRouter(
  // initialLocation: '/settings',
  initialLocation: '/kyc/document/upload',
  // initialLocation: '/login',
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
    ),
    GoRoute(
      path: '/referral',
      builder: (context, state) => const ReferralPageScreen(),
    ),
    GoRoute(
      path: '/inbox',
      builder: (context, state) => const InboxScreen(),
    ),
    GoRoute(
      path: '/inbox/chat',
      builder: (context, state) => const InboxChatScreen(),
    ),

    // kyc settings route
    GoRoute(
      path: '/kyc/email/verify',
      builder: (context, state) => const KycEmailVerificationScreen(),
    ),
    GoRoute(
      path: '/kyc/code/verify',
      builder: (context, state) => const KycCodeScreenVerification(),
    ),
    GoRoute(
      path: '/kyc/personal/information',
      builder: (context, state) => const KycPersonalInformationScreen(),
    ),
    GoRoute(
      path: '/kyc/contact/info',
      builder: (context, state) => const KycContactInfoScreen(),
    ),
    GoRoute(
      path: '/kyc/document/upload',
      builder: (context, state) => const KycDocumentUploadScreen(),
    ),
    GoRoute(
      path: '/kyc/profile/pics',
      builder: (context, state) => const KycProfilePicsScreen(),
    ),
    GoRoute(
      path: '/kyc/company/information',
      builder: (context, state) => const KycCompanyInformationScreen(),
    ),
  ],
);

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

final GoRouter router = GoRouter(
  initialLocation: '/register',
  errorBuilder: (context, state) => const ErrorScreen(),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
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
      path: '/resetPassword',
      builder: (context, state) => const ResetPasswordScreen(),
    ),

    GoRoute(
      path: '/verificationCode',
      builder: (context, state) => const VerificationCodeScreen(),
    ),

    GoRoute(
      path: '/registerSuccess',
      builder: (context, state) => const RegisterSuccessScreen(),
    ),

    // Seller routes

    // User routes
  ],
);

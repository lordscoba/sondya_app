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
import 'package:sondya_app/presentation/pages/splash_screen.dart';
import 'package:sondya_app/presentation/pages/welcome_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/forgotPassword',
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
  ],
);

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
import 'package:sondya_app/presentation/pages/welcome_screen.dart';

final GoRouter router = GoRouter(
  // initialLocation: '/product/search',
  // initialLocation: '/product/details/65a305d57aedbbb6d5dec067/Calvin-sweater',
  // initialLocation: '/product/details/6571d47afc3e181dd7ede9cf/PS-5',
  initialLocation: '/service/details/65a111ccdf8051503766b374/hair-dressing',
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
  ],
);

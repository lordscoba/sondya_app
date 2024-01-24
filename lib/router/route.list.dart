// GoRouter configuration
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/pages/error_screen.dart';
import 'package:sondya_app/presentation/pages/home.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  errorBuilder: (context, state) => const ErrorScreen(),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHome(),
    ),
  ],
);

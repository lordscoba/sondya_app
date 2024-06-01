import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/auth.dart';

// final authUserProvider = StateNotifierProvider.autoDispose<AuthUserNotifier,
//     AsyncValue<Map<String, dynamic>>>((ref) {
//   return AuthUserNotifier();
// });

final createUserProvider = StateNotifierProvider.autoDispose<CreateUserNotifier,
    AsyncValue<Map<String, dynamic>>>((ref) {
  return CreateUserNotifier();
});

final loginUserProvider = StateNotifierProvider.autoDispose<LoginUserNotifier,
    AsyncValue<Map<String, dynamic>>>((ref) {
  return LoginUserNotifier();
});

final forgotPasswordUserProvider = StateNotifierProvider.autoDispose<
    ForgotPasswordUserNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return ForgotPasswordUserNotifier();
});

final verifyEmailUserProvider = StateNotifierProvider.autoDispose<
    VerifyEmailUserNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return VerifyEmailUserNotifier();
});

final resetPasswordUserProvider = StateNotifierProvider.autoDispose<
    ResetPasswordUserNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return ResetPasswordUserNotifier();
});

final logoutUserProvider = StateNotifierProvider.autoDispose<LogoutUserNotifier,
    AsyncValue<Map<String, dynamic>>>((ref) {
  return LogoutUserNotifier();
});

final isAuthenticatedTemp = StateProvider<bool>((ref) => false);

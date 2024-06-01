import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/user.order.dart';

final updateUserServiceOrderTermsProvider = StateNotifierProvider.autoDispose<
    UpdateUserServiceOrderTermsNotifier,
    AsyncValue<Map<String, dynamic>>>((ref) {
  return UpdateUserServiceOrderTermsNotifier();
});

final createUserServiceOrderProvider = StateNotifierProvider.autoDispose<
    CreateUserServiceOrderNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return CreateUserServiceOrderNotifier();
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/auth.dart';

final authUserProvider = StateNotifierProvider.autoDispose<AuthUserNotifier,
    AsyncValue<Map<String, dynamic>>>((ref) {
  return AuthUserNotifier();
});

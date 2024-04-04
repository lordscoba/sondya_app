import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sondya_app/data/remote/auth.dart';

final authUserProvider = StateNotifierProvider.autoDispose<AuthUserNotifier,
    AsyncValue<Map<String, dynamic>>>((ref) {
  return AuthUserNotifier();
});

final sharedPrefProvider = Provider((_) async {
  return await SharedPreferences.getInstance();
});

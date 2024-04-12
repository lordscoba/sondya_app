import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/profile.dart';

final profileProvider = StateNotifierProvider.autoDispose<ProfileNotifier,
    AsyncValue<Map<String, dynamic>>>((ref) {
  return ProfileNotifier();
});

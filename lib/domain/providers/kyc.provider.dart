import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/kyc.dart';

final kycUserProvider = StateNotifierProvider.autoDispose<KycUserNotifier,
    AsyncValue<Map<String, dynamic>>>((ref) {
  return KycUserNotifier();
});

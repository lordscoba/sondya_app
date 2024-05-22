import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/seller.withdrawal.dart';

final withdrawalRequestProvider = StateNotifierProvider.autoDispose<
    WithdrawalRequestNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return WithdrawalRequestNotifier();
});

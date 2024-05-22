import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/seller.account.dart';

final addBankAccountProvider = StateNotifierProvider.autoDispose<
    AddBankAccountNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return AddBankAccountNotifier();
});

final addPaypalAccountProvider = StateNotifierProvider.autoDispose<
    AddPaypalAccountNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return AddPaypalAccountNotifier();
});

final addPayoneerAccountProvider = StateNotifierProvider.autoDispose<
    AddPayoneerAccountNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return AddPayoneerAccountNotifier();
});

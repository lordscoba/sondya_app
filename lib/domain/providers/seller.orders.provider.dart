import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/seller.order.dart';

final updateSellerProductOrderProvider = StateNotifierProvider.autoDispose<
    UpdateSellerProductOrderNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return UpdateSellerProductOrderNotifier();
});

final updateSellerServiceOrderProvider = StateNotifierProvider.autoDispose<
    UpdateSellerServiceOrderNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return UpdateSellerServiceOrderNotifier();
});

final updateSellerServiceOrderTermsProvider = StateNotifierProvider.autoDispose<
    UpdateSellerServiceOrderTermsNotifier,
    AsyncValue<Map<String, dynamic>>>((ref) {
  return UpdateSellerServiceOrderTermsNotifier();
});

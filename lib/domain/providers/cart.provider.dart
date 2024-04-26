import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/local/cart.dart';

final addToCartProvider = StateNotifierProvider.autoDispose<AddToCartNotifier,
    AsyncValue<Map<String, dynamic>>>((ref) {
  return AddToCartNotifier();
});

final updateCartProvider = StateNotifierProvider.autoDispose<AddToCartNotifier,
    AsyncValue<Map<String, dynamic>>>((ref) {
  return AddToCartNotifier();
});

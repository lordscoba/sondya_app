import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/local/cart.dart';

final addToCartProvider = StateNotifierProvider.autoDispose<AddToCartNotifier,
    AsyncValue<Map<String, dynamic>>>((ref) {
  return AddToCartNotifier();
});

final updateCartProvider = StateNotifierProvider.autoDispose<UpdateCartNotifier,
    AsyncValue<Map<String, dynamic>>>((ref) {
  return UpdateCartNotifier();
});

final updateCartVariantProvider = StateNotifierProvider.autoDispose<
    UpdateCartVariantNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return UpdateCartVariantNotifier();
});

final removeFromCartProvider = StateNotifierProvider.autoDispose<
    RemoveFromCartNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return RemoveFromCartNotifier();
});

final removeAllCartProvider = StateNotifierProvider.autoDispose<
    RemoveAllCartNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return RemoveAllCartNotifier();
});

final updateShippingDestinationProvider = StateNotifierProvider.autoDispose<
    UpdateLocalShippingDestinationNotifier,
    AsyncValue<Map<String, dynamic>>>((ref) {
  // ignore: unused_result
  ref.refresh(getShipmentDestinationdDataProvider);
  return UpdateLocalShippingDestinationNotifier();
});

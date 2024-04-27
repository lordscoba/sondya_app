import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/local/wishlist.dart';

final addToWishlistProvider = StateNotifierProvider.autoDispose<
    AddToWishlistNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return AddToWishlistNotifier();
});
final removeFromWishlistProvider = StateNotifierProvider.autoDispose<
    RemoveFromWishlistNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return RemoveFromWishlistNotifier();
});

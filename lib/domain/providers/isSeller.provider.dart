import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/local/is_seller.dart';

final isSellerProvider =
    StateNotifierProvider.autoDispose<IsSellerNotifier, AsyncValue<bool>>(
        (ref) {
  return IsSellerNotifier();
});

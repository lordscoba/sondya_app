import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddToCartNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  AddToCartNotifier() : super(const AsyncValue.data({}));

  Future<void> addToCart(data) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // print data
      print(data);
    } on Error catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}

class UpdateCartNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  UpdateCartNotifier() : super(const AsyncValue.data({}));
}

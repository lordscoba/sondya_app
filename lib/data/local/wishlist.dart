import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/hive_boxes.dart';
import 'package:sondya_app/domain/hive_models/wishlist/wishlist.dart';

class AddToWishlistNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  AddToWishlistNotifier() : super(const AsyncValue.data({}));

  Future<void> addToWishlist(String id, String category, String name) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // check if product is already in wishlist
      final bool check = boxForWishList.values
          .where((element) => element.id == id && element.category == category)
          .isEmpty;

      if (check) {
        var person = WishListType(id: id, category: category, name: name);
        boxForWishList.add(person);
      }
      state = const AsyncValue.data({});
    } on Error catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}

class RemoveFromWishlistNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  RemoveFromWishlistNotifier() : super(const AsyncValue.data({}));

  Future<void> removeFromWishlist(String id, String category) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // remove product from wishlist
      final Map<dynamic, dynamic> dataMap = boxForWishList.toMap();
      dynamic desiredKey;
      dataMap.forEach((key, value) {
        if (value.id == id) {
          desiredKey = key;
        }
      });
      boxForWishList.delete(desiredKey);

      state = const AsyncValue.data({});
    } on Error catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  Future<void> removeAllWishlist(String id, String category) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // remove all products from wishlist
      boxForWishList.clear();

      state = const AsyncValue.data({});
    } on Error catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}

final getWishlistDataProvider =
    FutureProvider.autoDispose<List<WishListType>>((ref) async {
  try {
    // get boxForWishList data list
    // final list = WishListType.fromJson(boxForWishList.values.toList());
    final list = boxForWishList.values.toList();
    return list as List<WishListType>;
  } on Error catch (e) {
    return throw Exception("Failed to fetch map data error: ${e.toString()}");
  }
});

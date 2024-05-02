import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/api_constants.dart';
import 'package:sondya_app/data/hive_boxes.dart';
import 'package:sondya_app/domain/hive_models/cart/cart.dart';
import 'package:sondya_app/domain/hive_models/shipment_info/shipment.dart';
import 'package:sondya_app/domain/models/cart.dart';

class AddToCartNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  AddToCartNotifier() : super(const AsyncValue.data({}));

  Future<void> addToCart(data) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // check if product is already in wishlist
      final bool check = boxForCart.values
          .where((element) => element.id == data['_id'])
          .isEmpty;

      if (check) {
        var person = ProductOrderType(
          id: data['_id'],
          orderQuantity: data['order_quantity'],
          name: data['name'],
          tax: 1, // TODO : add tax
          shippingCost: 3, // TODO : add shipping cost
          discount: 1, // TODO : add discount
        );

        boxForCart.add(person);
      } else {
        // update quantity in cart
        final Map<dynamic, dynamic> dataMap = boxForCart.toMap();
        dynamic desiredKey;
        dataMap.forEach((key, value) {
          if (value.id == data['_id']) {
            desiredKey = key;
          }
        });

        // get data for desired key
        final ProductOrderType dataForDesiredKey = boxForCart.get(desiredKey);

        // update quantity in dataForDesiredKey data
        dataForDesiredKey.orderQuantity += data['order_quantity'] as int;
        boxForCart.put(desiredKey, dataForDesiredKey);
      }
      state = const AsyncValue.data({});
    } on Error catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}

class UpdateCartNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  UpdateCartNotifier() : super(const AsyncValue.data({}));

  Future<void> updateCart(data) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // update quantity in cart
      final Map<dynamic, dynamic> dataMap = boxForCart.toMap();
      dynamic desiredKey;
      dataMap.forEach((key, value) {
        if (value.id == data['_id']) {
          desiredKey = key;
        }
      });

      // get data for desired key
      final ProductOrderType dataForDesiredKey = boxForCart.get(desiredKey);

      // update quantity in dataForDesiredKey data
      dataForDesiredKey.orderQuantity = data['order_quantity'] as int;
      boxForCart.put(desiredKey, dataForDesiredKey);
      state = const AsyncValue.data({});
    } on Error catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}

class UpdateCartVariantNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  UpdateCartVariantNotifier() : super(const AsyncValue.data({}));

  Future<void> updateCartVariant(String id, String name, data) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // update quantity in cart
      final Map<dynamic, dynamic> dataMap = boxForCart.toMap();
      dynamic desiredKey;
      dataMap.forEach((key, value) {
        if (value.id == id) {
          desiredKey = key;
        }
      });

      // check if product is already in wishlist
      if (desiredKey != null) {
        // get data for desired key
        final ProductOrderType dataForDesiredKey = boxForCart.get(desiredKey);
        if (dataForDesiredKey.selectedVariants != null) {
          dataForDesiredKey.selectedVariants!.addAll(data);
        } else {
          dataForDesiredKey.selectedVariants = data;
        }
      } else {
        // add product to cart
        var person = ProductOrderType(
          id: id,
          selectedVariants: data,
          orderQuantity: 1,
          name: name,
          tax: 1, // TODO : add tax
          shippingCost: 3, // TODO : add shipping cost
          discount: 1, // TODO : add discount
        );
        boxForCart.add(person);
      }

      state = const AsyncValue.data({});
    } on Error catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}

class RemoveFromCartNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  RemoveFromCartNotifier() : super(const AsyncValue.data({}));

  Future<void> removeFromCart(String id) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // remove product from wishlist
      final Map<dynamic, dynamic> dataMap = boxForCart.toMap();
      dynamic desiredKey;
      dataMap.forEach((key, value) {
        if (value.id == id) {
          desiredKey = key;
        }
      });
      boxForCart.delete(desiredKey);

      state = const AsyncValue.data({});

      // print data
      // print(id);
    } on Error catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}

class RemoveAllCartNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  RemoveAllCartNotifier() : super(const AsyncValue.data({}));

  Future<void> removeAllCart() async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // remove all products from wishlist
      boxForCart.clear();

      state = const AsyncValue.data({});
    } on Error catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}

final getTotalCartProvider = FutureProvider.autoDispose<int>((ref) async {
  try {
    // get boxForCart data list
    final totalList = boxForCart.values.toList().length;
    return totalList;
  } on Error catch (e) {
    return throw Exception("Failed to fetch map data error: ${e.toString()}");
  }
});

final getCartDataProvider =
    FutureProvider.autoDispose<List<dynamic>>((ref) async {
  try {
    // get boxForCart data list
    final list = boxForCart.values.toList();
    return list;
  } on Error catch (e) {
    return throw Exception("Failed to fetch map data error: ${e.toString()}");
  }
});

final getCartDataByIdProvider = FutureProvider.autoDispose
    .family<ProductOrderType, String>((ref, String id) async {
  try {
    final Map<dynamic, dynamic> dataMap = boxForCart.toMap();
    dynamic desiredKey;
    dataMap.forEach((key, value) {
      if (value.id == id) {
        desiredKey = key;
      }
    });
    // get data for desired key
    final ProductOrderType dataForDesiredKey = boxForCart.get(desiredKey);
    return dataForDesiredKey;
  } on Error catch (e) {
    return throw Exception("Failed to fetch map data error: ${e.toString()}");
  }
});

final totalingProvider = FutureProvider.autoDispose<TotalingType>((ref) async {
  try {
    // get boxForCart data list
    final list = boxForCart.values.toList();

    // init dio
    final dio = Dio();

    // init total
    final TotalingType total = TotalingType(
      totalTax: 0.0,
      totalShippingFee: 0.0,
      totalDiscount: 0.0,
      subTotal: 0.0,
      total: 0.0,
    );

    if (list.isNotEmpty) {
      for (var element in list) {
        // get total tax
        total.totalTax = (total.totalTax ?? 0) + element.tax.toDouble();

        // get total shipping fee
        total.totalShippingFee =
            (total.totalShippingFee ?? 0) + element.shippingCost.toDouble();

        // get total discount
        total.totalDiscount =
            (total.totalDiscount ?? 0) + element.discount.toDouble();

        final response =
            await dio.get("${EnvironmentHomeConfig.productPrice}${element.id}");
        if (response.statusCode == 200) {
          final data = response.data as Map<String, dynamic>;

          // get total discount
          total.subTotal = (total.subTotal ?? 0) +
              (data["data"]["current_price"].toDouble() *
                  element.orderQuantity);
        } else {
          throw Exception('Failed to fetch map data');
        }
      }

      // get total
      total.total = (total.subTotal ?? 0.0) +
          (total.totalTax ?? 0.0) +
          (total.totalShippingFee ?? 0.0) -
          (total.totalDiscount ?? 0.0);
    }

    return total;
  } on Error catch (e) {
    return throw Exception("Failed to fetch map data error: ${e.toString()}");
  }
});

// shipping destination for cart
class UpdateLocalShippingDestinationNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  UpdateLocalShippingDestinationNotifier() : super(const AsyncValue.data({}));

  Future<void> updateDestination(dynamic data) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // convert data json  to ShippingDestinationType
      final shippingDestination = ShippingDestinationType.fromJson(data);

      // update quantity in cart
      boxForShipment.put(0, shippingDestination);

      state = const AsyncValue.data({});
    } on Error catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}

final getShipmentDestinationdDataProvider =
    FutureProvider.autoDispose<ShippingDestinationType>((ref) async {
  try {
    // get boxForCart data list
    final list = boxForShipment.get(0);
    return list;
  } on Error catch (e) {
    return throw Exception("Failed to fetch map data error: ${e.toString()}");
  }
});

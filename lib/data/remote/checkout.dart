import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/api_constants.dart';
import 'package:sondya_app/data/hive_boxes.dart';
import 'package:sondya_app/data/local/get_local_auth.dart';
import 'package:sondya_app/data/remote/home.dart';
import 'package:sondya_app/data/repositories/token_interceptors.dart';
import 'package:sondya_app/domain/hive_models/auth/auth.dart';
import 'package:sondya_app/domain/hive_models/cart/cart.dart';
import 'package:sondya_app/domain/hive_models/shipment_info/shipment.dart';
import 'package:sondya_app/domain/models/checkout.dart';
import 'package:sondya_app/domain/models/home.dart';
import 'package:sondya_app/domain/providers/checkout.provider.dart';

final getShippingAddressProvider = FutureProvider.autoDispose
    .family<ShippingDestinationType, String>((ref, String mode) async {
  // initialize dio and add interceptors
  final dio = Dio();
  dio.interceptors.add(const AuthInterceptor());

  // define shipping destination
  ShippingDestinationType dest = ShippingDestinationType(
    id: '0',
    country: '',
    state: '',
    city: '',
    address: '',
    zipcode: '',
    phoneNumber: '',
  );

  if (mode == 'local') {
    try {
      // get boxForCart data list
      dest = boxForShipment.get(0);
      return dest;
    } on Error catch (e) {
      return throw Exception("Failed to fetch map data error: ${e.toString()}");
    }
  } else {
    try {
      // get auth user id
      AuthInfo localAuth = await getLocalAuth();
      String userId = localAuth.id;

      final response =
          await dio.get(EnvironmentProfileConfig.getUserById + userId);
      if (response.statusCode == 200 || response.statusCode == 201) {
        dest = ShippingDestinationType(
            id: response.data["data"]["_id"].toString(),
            address: response.data["data"]["address"],
            city: response.data["data"]["city"],
            state: response.data["data"]["state"],
            country: response.data["data"]["country"],
            zipcode: response.data["data"]["zip_code"],
            phoneNumber: response.data["data"]["phone_number"]);
        return dest;
      } else {
        throw Exception('Failed to fetch map data');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response?.data;
      } else {
        return throw Exception("Failed to fetch map data error: ${e.message}");
      }
    }
  }
});

final verifyCheckoutPaymentProvider = FutureProvider.autoDispose
    .family<Map<String, dynamic>, String>((ref, String txRef) async {
  try {
    final dio = Dio();
    dio.interceptors.add(const AuthInterceptor());

    final response =
        await dio.get(EnvironmentUserPaymentConfig.verifyPayment + txRef);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      throw Exception('Failed to fetch map data');
    }
  } on DioException catch (e) {
    if (e.response != null) {
      // debugPrint(e.response?.data.toString());
      return e.response?.data;
    } else {
      // debugPrint(e.message.toString());
      return throw Exception("Failed to fetch map data error: ${e.message}");
    }
  }
});

final createProductOrderProvider = FutureProvider.autoDispose
    .family<Map<String, dynamic>, Map<String, dynamic>>((ref, data) async {
  try {
    final dio = Dio();
    dio.interceptors.add(const AuthInterceptor());

    ref.watch(productOrderDataprovider.notifier).state.paymentStatus =
        data["data"]["data"]["status"];
    ref.watch(productOrderDataprovider.notifier).state.orderStatus =
        "order placed";

    final response = await dio.post(
      EnvironmentUserProductOrderConfig.productOrder,
      data: ref.watch(productOrderDataprovider).toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // clear box
      boxForCart.clear();

      return response.data;
    } else {
      throw Exception('Failed to fetch map data');
    }
  } on DioException catch (e) {
    if (e.response != null) {
      // debugPrint(e.response?.data.toString());
      return e.response?.data;
    } else {
      // debugPrint(e.message.toString());
      return throw Exception("Failed to fetch map data error: ${e.message}");
    }
  } finally {
    // await boxForCart.close();
  }
});

typedef ServicePaymentParameters = ({String txRef, dynamic data1});

final verifyCheckoutServicePaymentProvider = FutureProvider.autoDispose
    .family<Map<String, dynamic>, ServicePaymentParameters>(
        (ref, servicePaymentParameters) async {
  try {
    final dio = Dio();
    dio.interceptors.add(const AuthInterceptor());

    final response = await dio.get(EnvironmentUserPaymentConfig.verifyPayment +
        servicePaymentParameters.txRef);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // if (response.data["data"]["data"]["status"] == "successful") {
      final response2 = await dio.post(
        EnvironmentUserServiceOrderConfig.updateServiceOrder,
        data: servicePaymentParameters.data1,
      );

      if (response2.statusCode == 200 || response2.statusCode == 201) {}
      //   return response.data;
      // }
      return response.data;
    } else {
      throw Exception('Failed to fetch map data');
    }
  } on DioException catch (e) {
    if (e.response != null) {
      // debugPrint(e.response?.data.toString());
      return e.response?.data;
    } else {
      // debugPrint(e.message.toString());
      return throw Exception("Failed to fetch map data error: ${e.message}");
    }
  }
});

final getCheckoutProductDetailsProvider = FutureProvider.autoDispose
    .family<Map<String, dynamic>, ItemDetailsParameters>(
        (ref, arguments) async {
  try {
    final dio = Dio();
    dio.interceptors.add(const AuthInterceptor());

    final response = await dio.get(
        "${EnvironmentHomeConfig.productDetail}${arguments.id}/${arguments.name}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      // boxForCart = await Hive.openBox<ProductOrderType>(cartBoxString);

      final Map<dynamic, dynamic> dataMap = boxForCart.toMap();
      dynamic desiredKey;
      dataMap.forEach((key, value) {
        if (value.id == response.data["data"]["_id"]) {
          desiredKey = key;
        }
      });

      // get data for desired key
      final ProductOrderType dataForDesiredKey = boxForCart.get(desiredKey);

      final CheckoutItems item = CheckoutItems(
        id: response.data["data"]["_id"] ?? "",
        name: response.data["data"]["name"] ?? "",
        owner: Owner.fromJson(response.data["data"]["owner"]),
        category: response.data["data"]["category"] ?? "",
        subCategory: response.data["data"]["sub_category"] ?? "",
        description: response.data["data"]["description"] ?? "",
        totalStock: response.data["data"]["total_stock"] ?? 0,
        tag: response.data["data"]["tag"] ?? "",
        brand: response.data["data"]["brand"] ?? "",
        model: response.data["data"]["model"] ?? "",
        oldPrice: response.data["data"]["old_price"].toDouble() ?? 0.0,
        currentPrice: response.data["data"]["current_price"].toDouble() ?? 0.0,
        discountPercentage:
            response.data["data"]["discount_percentage"].toDouble() ?? 0.0,
        vatPercentage:
            response.data["data"]["vat_percentage"].toDouble() ?? 0.0,
        productStatus: response.data["data"]["product_status"] ?? "",
        rating: response.data["data"]["rating"].toDouble() ?? 0.0,
        totalRating: response.data["data"]["total_rating"] ?? 0.0,
        totalVariants: response.data["data"]["total_variants"] ?? 0,
        country: response.data["data"]["country"] ?? "",
        state: response.data["data"]["state"] ?? "",
        city: response.data["data"]["city"] ?? "",
        zipCode: response.data["data"]["zip_code"] ?? "",
        address: response.data["data"]["address"] ?? "",
        image: (response.data?['data']?['image'] as List?)
                ?.map((e) => ImageType.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        createdAt: response.data["data"]["created_at"],
        updatedAt: response.data["data"]["updated_at"],
        selectedVariants: dataForDesiredKey.selectedVariants ?? {},
        orderQuantity: dataForDesiredKey.orderQuantity,
        subTotal: dataForDesiredKey.orderQuantity.toDouble() *
            response.data["data"]["current_price"].toDouble(),
        shippingFee: dataForDesiredKey.shippingCost?.toDouble() ?? 0.0,
        tax: dataForDesiredKey.tax?.toDouble() ?? 0.0,
        discount: dataForDesiredKey.discount?.toDouble() ?? 0.0,
        totalPrice: (dataForDesiredKey.orderQuantity.toDouble() *
                response.data["data"]["current_price"].toDouble()) +
            dataForDesiredKey.shippingCost!.toDouble() +
            dataForDesiredKey.tax!.toDouble() -
            dataForDesiredKey.discount!.toDouble(),
        trackDistanceTime: dataForDesiredKey.trackDistanceTime,
      );

      List<CheckoutItems>? checkoutOne = ref
              .watch(productOrderDataprovider.notifier)
              .state
              .checkoutItems
              ?.toList() ??
          [];
      checkoutOne.add(item);

      ref.watch(productOrderDataprovider.notifier).state.checkoutItems =
          checkoutOne;

      return response.data as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch map data');
    }
  } on DioException catch (e) {
    if (e.response != null) {
      // debugPrint(e.response?.data.toString());
      return e.response?.data;
    } else {
      // debugPrint(e.message.toString());
      return throw Exception("Failed to fetch map data error: ${e.message}");
    }
  }
});

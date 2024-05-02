import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/api_constants.dart';
import 'package:sondya_app/data/hive_boxes.dart';
import 'package:sondya_app/data/local/get_local_auth.dart';
import 'package:sondya_app/data/repositories/token_interceptors.dart';
import 'package:sondya_app/domain/hive_models/auth/auth.dart';
import 'package:sondya_app/domain/hive_models/shipment_info/shipment.dart';

// typedef ItemDetailsParameters = ({String mode, String name});

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
        await dio.get(EnvironmentProductCheckoutConfig.verifyPayment + txRef);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
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
});

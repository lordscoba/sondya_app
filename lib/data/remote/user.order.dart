import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/api_constants.dart';
import 'package:sondya_app/data/local/get_local_auth.dart';
import 'package:sondya_app/data/repositories/token_interceptors.dart';
import 'package:sondya_app/domain/hive_models/auth/auth.dart';

final getUserProductOrdersProvider =
    FutureProvider.autoDispose<List<dynamic>>((ref) async {
  try {
    final dio = Dio();
    dio.interceptors.add(const AuthInterceptor());

    // get auth user id
    AuthInfo localAuth = await getLocalAuth();
    String userId = localAuth.id;

    final response = await dio
        .get(EnvironmentUserProductOrderConfig.getproductOrders + userId);
    // debugPrint(response.data.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data["data"] as List<dynamic>;
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

final getUserProductOrdersDetailsDetailsProvider = FutureProvider.family
    .autoDispose<Map<String, dynamic>, String>((ref, String id) async {
  try {
    final dio = Dio();
    dio.interceptors.add(const AuthInterceptor());

    final response = await dio
        .get(EnvironmentUserProductOrderConfig.getproductOrdersById + id);
    // debugPrint(response.data.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data["data"]["data"] as Map<String, dynamic>;
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

final getUserServiceOrdersProvider =
    FutureProvider.autoDispose<List<dynamic>>((ref) async {
  try {
    final dio = Dio();
    dio.interceptors.add(const AuthInterceptor());

    // get auth user id
    AuthInfo localAuth = await getLocalAuth();
    String userId = localAuth.id;

    final response = await dio
        .get(EnvironmentUserServiceOrderConfig.getUserServiceOrders + userId);
    // debugPrint(response.data.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data["data"] as List<dynamic>;
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

final checkUserServiceOrderProvider = FutureProvider.autoDispose
    .family<Map<String, dynamic>?, dynamic>((ref, data) async {
  try {
    final dio = Dio();
    dio.interceptors.add(const AuthInterceptor());

    // get auth user id
    AuthInfo localAuth = await getLocalAuth();
    String userId = localAuth.id;

    data["buyer_id"] = userId;

    // print(data);

    final response = await dio
        .post(EnvironmentUserServiceOrderConfig.checkServiceOrder, data: data);
    // debugPrint(response.data.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print(response.data["data"]);
      return response.data["data"] as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch map data');
    }
  } on DioException catch (e) {
    if (e.response != null) {
      debugPrint(e.response?.data.toString());
      return e.response?.data;
    } else {
      debugPrint(e.message.toString());
      return throw Exception("Failed to fetch map data error: ${e.message}");
    }
  }
});

final getUserServiceOrdersDetailsDetailsProvider = FutureProvider.family
    .autoDispose<Map<String, dynamic>, String>((ref, String id) async {
  try {
    final dio = Dio();
    dio.interceptors.add(const AuthInterceptor());

    final response = await dio
        .get(EnvironmentUserServiceOrderConfig.getServiceOrderById + id);
    // debugPrint(response.data.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data["data"] as Map<String, dynamic>;
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

class UpdateUserServiceOrderTermsNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  UpdateUserServiceOrderTermsNotifier() : super(const AsyncValue.data({}));

  Future<void> updateOrder(data, String id) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // initialize dio and add interceptors
      final dio = Dio();
      dio.interceptors.add(const AuthInterceptor());

      // // get auth user id
      // AuthInfo localAuth = await getLocalAuth();
      // String userId = localAuth.id;

      // Make the PUT request
      final response = await dio.put(
        EnvironmentUserServiceOrderConfig.updateTerms + id,
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        state = AsyncValue.data(response.data as Map<String, dynamic>);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        state = AsyncValue.error(e.response?.data['message'], e.stackTrace);
        // debugPrint(e.response?.data['message'].toString());
      } else {
        state = AsyncValue.error(e.message.toString(), e.stackTrace);
        // debugPrint(e.message.toString());
      }
    }
  }
}

class CreateUserServiceOrderNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  CreateUserServiceOrderNotifier() : super(const AsyncValue.data({}));

  Future<void> createOrder(data, String serviceId) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // initialize dio and add interceptors
      final dio = Dio();
      dio.interceptors.add(const AuthInterceptor());

      AuthInfo localAuth = await getLocalAuth();
      data["buyer"] = localAuth.toJson();

      data["buyer"].remove("type");
      data["buyer"].remove("token");
      data["buyer"].remove("email_verified");
      data["buyer"].remove("kyc_completed");
      data["buyer"].remove("kyc_completed");

      // debugPrint(data.toString());

      // // get auth user id
      // AuthInfo localAuth = await getLocalAuth();
      // String userId = localAuth.id;

      // Make the POST request
      final response = await dio.post(
        EnvironmentUserServiceOrderConfig.createServiceOrder + serviceId,
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        state = AsyncValue.data(response.data as Map<String, dynamic>);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        state = AsyncValue.error(e.response?.data['message'], e.stackTrace);
        // debugPrint(e.response?.data['message'].toString());
      } else {
        state = AsyncValue.error(e.message.toString(), e.stackTrace);
        // debugPrint(e.message.toString());
      }
    }
  }
}

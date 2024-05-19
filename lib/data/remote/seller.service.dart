import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/api_constants.dart';
import 'package:sondya_app/data/local/get_local_auth.dart';
import 'package:sondya_app/data/repositories/token_interceptors.dart';
import 'package:sondya_app/domain/hive_models/auth/auth.dart';

final getSellerServicesProvider = FutureProvider.family
    .autoDispose<Map<String, dynamic>, String>((ref, String search) async {
  try {
    final dio = Dio();
    dio.interceptors.add(const AuthInterceptor());

    // get auth user id
    AuthInfo localAuth = await getLocalAuth();
    String userId = localAuth.id;

    final response = await dio
        .get("${EnvironmentSellerServiceConfig.getAll}$userId/$search");
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

final getSellerServicesDetailsProvider = FutureProvider.family
    .autoDispose<Map<String, dynamic>, String>((ref, String id) async {
  try {
    final dio = Dio();
    dio.interceptors.add(const AuthInterceptor());

    final response = await dio.get(EnvironmentSellerServiceConfig.getByID + id);
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

final getSellerDeleteServiceProvider = FutureProvider.family
    .autoDispose<Map<String, dynamic>, String>((ref, String id) async {
  try {
    final dio = Dio();
    dio.interceptors.add(const AuthInterceptor());

    final response =
        await dio.delete(EnvironmentSellerServiceConfig.delete + id);
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

class SellerAddServiceNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  SellerAddServiceNotifier() : super(const AsyncValue.data({}));

  Future<void> addProduct(data) async {
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
      final response = await dio.post(
        EnvironmentSellerServiceConfig.create,
        data: data,
      );
      // Make the PUT request
      // final response = await dio.put(
      //   "${EnvironmentKycConfig.kycPersonalDetails}/haha/dgsggsgs",
      //   data: details,
      // );

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

class SellerEditServiceNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  SellerEditServiceNotifier() : super(const AsyncValue.data({}));

  Future<void> editService(data) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // initialize dio and add interceptors
      final dio = Dio();
      dio.interceptors.add(const AuthInterceptor());

      // get auth user id
      AuthInfo localAuth = await getLocalAuth();
      String userId = localAuth.id;

      // Make the PUT request
      final response = await dio.put(
        EnvironmentSellerServiceConfig.update + userId,
        data: data,
      );
      // Make the PUT request
      // final response = await dio.put(
      //   "${EnvironmentKycConfig.kycPersonalDetails}/haha/dgsggsgs",
      //   data: details,
      // );

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

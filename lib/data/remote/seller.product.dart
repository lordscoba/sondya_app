import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:sondya_app/data/api_constants.dart';
import 'package:sondya_app/data/local/get_local_auth.dart';
import 'package:sondya_app/data/repositories/token_interceptors.dart';
import 'package:sondya_app/domain/hive_models/auth/auth.dart';
import 'package:sondya_app/domain/models/checkout.dart';
import 'package:sondya_app/domain/models/product.dart';

final getSellerProductsProvider = FutureProvider.family
    .autoDispose<Map<String, dynamic>, String>((ref, String search) async {
  try {
    final dio = Dio();
    dio.interceptors.add(const AuthInterceptor());

    // get auth user id
    AuthInfo localAuth = await getLocalAuth();
    String userId = localAuth.id;

    final response = await dio
        .get("${EnvironmentSellerProductConfig.getAll}$userId/$search");
    // debugPrint(response.data["data"].toString());
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

final getSellerProductsDetailsProvider = FutureProvider.family
    .autoDispose<Map<String, dynamic>, String>((ref, String id) async {
  try {
    final dio = Dio();
    dio.interceptors.add(const AuthInterceptor());

    final response = await dio.get(EnvironmentSellerProductConfig.getByID + id);
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

final getSellerDeleteProductProvider = FutureProvider.family
    .autoDispose<Map<String, dynamic>, String>((ref, String id) async {
  try {
    final dio = Dio();
    dio.interceptors.add(const AuthInterceptor());

    final response =
        await dio.delete(EnvironmentSellerProductConfig.delete + id);
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

class SellerAddProductNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  SellerAddProductNotifier() : super(const AsyncValue.data({}));

  Future<void> addProduct(ProductDataModel data) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // initialize dio and add interceptors
      final dio = Dio();
      dio.interceptors.add(const AuthInterceptor());

      // get auth user id
      AuthInfo localAuth = await getLocalAuth();

      // assign local auth to owner
      Owner owner = Owner(
        id: localAuth.id,
        username: localAuth.username,
        email: localAuth.email,
        phoneNumber: localAuth.phoneNumber,
      );

      // assign owner to data
      data.owner = owner;

      // assign image to formdata
      List<MultipartFile> imageList = [];
      for (var element in data.image!) {
        final mimeTypeData = lookupMimeType(element.path);
        imageList.add(
          await MultipartFile.fromFile(element.path,
              filename: element.name,
              contentType:
                  MediaType('image', mimeTypeData!.split('/').last.toString())),
        );
      }

      final formData = FormData.fromMap(
        {
          ...data.toJson(),
          'image': imageList,
        },
      );

      // Make the POST request
      final response = await dio.post(
        EnvironmentSellerProductConfig.create,
        data: formData,
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

class SellerEditProductNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  SellerEditProductNotifier() : super(const AsyncValue.data({}));

  Future<void> editProduct(ProductDataModel data, String id) async {
    try {
      // print(id);
      // print(data.toJson());
      // Set loading state
      state = const AsyncValue.loading();

      // initialize dio and add interceptors
      final dio = Dio();
      dio.interceptors.add(const AuthInterceptor());

      // get auth user id
      AuthInfo localAuth = await getLocalAuth();

      // assign local auth to owner
      Owner owner = Owner(
        id: localAuth.id,
        username: localAuth.username,
        email: localAuth.email,
        phoneNumber: localAuth.phoneNumber ?? "",
      );

      // assign owner to data
      data.owner = owner;

      // assign image to formdata
      List<MultipartFile> imageList = [];
      if (data.image != null) {
        for (var element in data.image!) {
          final mimeTypeData = lookupMimeType(element.path);
          imageList.add(
            await MultipartFile.fromFile(element.path,
                filename: element.name,
                contentType: MediaType(
                    'image', mimeTypeData!.split('/').last.toString())),
          );
        }
      }

      final formData = FormData.fromMap(
        {...data.toJson(), 'image': imageList},
      );

      // Make the PUT request
      final response = await dio.put(
        EnvironmentSellerProductConfig.update + id,
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        state = AsyncValue.data(response.data as Map<String, dynamic>);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        state = AsyncValue.error(e.response?.data['message'], e.stackTrace);
        debugPrint(e.response?.data['message'].toString());
      } else {
        state = AsyncValue.error(e.message.toString(), e.stackTrace);
        debugPrint(e.message.toString());
      }
    }
  }
}

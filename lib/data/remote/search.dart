import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/api_constants.dart';

final getProductSearchProvider = FutureProvider.family
    .autoDispose<List<dynamic>, String>((ref, String search) async {
  try {
    final dio = Dio();

    final response =
        await dio.get(EnvironmentHomeConfig.productsSearch + search);
    // debugPrint(response.data.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data["data"]["products"] as List<dynamic>;
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

final getServiceSearchProvider = FutureProvider.family
    .autoDispose<Map<String, dynamic>, String>((ref, String search) async {
  try {
    final dio = Dio();

    final response =
        await dio.get(EnvironmentHomeConfig.servicesSearch + search);
    if (response.statusCode == 200 || response.statusCode == 201) {
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

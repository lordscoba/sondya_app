import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/api_constants.dart';

final getProductCategoryProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  try {
    final dio = Dio();

    final response = await dio.get(EnvironmentHomeConfig.productsCategory);
    if (response.statusCode == 200) {
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

final getServiceCategoryProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  try {
    final dio = Dio();

    final response = await dio.get(EnvironmentHomeConfig.servicesCategory);
    if (response.statusCode == 200) {
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

final gethomeProductsProvider = FutureProvider.family
    .autoDispose<Map<String, dynamic>, String>((ref, String search) async {
  try {
    final dio = Dio();

    final response = await dio.get(EnvironmentHomeConfig.products + search);
    if (response.statusCode == 200) {
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

final gethomeServicesProvider = FutureProvider.family
    .autoDispose<Map<String, dynamic>, String>((ref, String search) async {
  try {
    final dio = Dio();

    final response = await dio.get(EnvironmentHomeConfig.services + search);
    if (response.statusCode == 200) {
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

typedef ItemDetailsParameters = ({String id, String name});

final getProductDetailsProvider = FutureProvider.autoDispose
    .family<Map<String, dynamic>, ItemDetailsParameters>(
        (ref, arguments) async {
  try {
    final dio = Dio();

    final response = await dio.get(
        "${EnvironmentHomeConfig.productDetail}${arguments.id}/${arguments.name}");
    if (response.statusCode == 200) {
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

final getServiceDetailsProvider = FutureProvider.autoDispose
    .family<Map<String, dynamic>, ItemDetailsParameters>(
        (ref, arguments) async {
  try {
    final dio = Dio();

    final response = await dio.get(
        "${EnvironmentHomeConfig.serviceDetail}${arguments.id}/${arguments.name}");
    if (response.statusCode == 200) {
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

typedef ReviewDataParameters = ({String id, String category});

final getReviewStatsProvider = FutureProvider.autoDispose
    .family<Map<String, dynamic>, ReviewDataParameters>((ref, arguments) async {
  try {
    final dio = Dio();

    final response = await dio.get(
        "${EnvironmentHomeConfig.getReviewStat}${arguments.category}/${arguments.id}");
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

typedef ReviewDataListParameters = ({
  String id,
  String category,
  int limit,
  int page,
  String search
});
final getReviewListProvider = FutureProvider.autoDispose
    .family<Map<String, dynamic>, ReviewDataListParameters>(
        (ref, arguments) async {
  try {
    final dio = Dio();

    final queryString =
        "?limit=${arguments.limit}&page=${arguments.page}&search=${arguments.search}";

    final response = await dio.get(
        "${EnvironmentHomeConfig.listReviews}${arguments.category}/${arguments.id}$queryString");
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

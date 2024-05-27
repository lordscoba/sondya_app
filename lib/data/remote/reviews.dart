import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/api_constants.dart';
import 'package:sondya_app/data/local/get_local_auth.dart';
import 'package:sondya_app/data/repositories/token_interceptors.dart';
import 'package:sondya_app/domain/hive_models/auth/auth.dart';

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

class CreateReviewNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  CreateReviewNotifier() : super(const AsyncValue.data({}));

  Future<void> createReview(data) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // initialize dio and add interceptors
      final dio = Dio();
      dio.interceptors.add(const AuthInterceptor());

      // get auth user id
      AuthInfo localAuth = await getLocalAuth();
      String userId = localAuth.id;

      data['user_id'] = userId;

      print(data);

      // Make the POST request
      final response = await dio.post(
        EnvironmentHomeConfig.createReview,
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

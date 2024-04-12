import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/api_constants.dart';
import 'package:sondya_app/data/local/token_interceptors.dart';

class KycUserNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  KycUserNotifier() : super(const AsyncValue.data({}));

  Future<void> kycVerifyEmail(email) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // Add your custom interceptors here (optional)
      final dio = Dio();
      dio.interceptors.add(const AuthInterceptor());

      // Make the POST request
      final response = await dio.post(
        EnvironmentKycConfig.kycVerifyEmail,
        data: email,
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

  Future<void> kycVerifyCode(code, String userId) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // Add your custom interceptors here (optional)
      final dio = Dio();
      dio.interceptors.add(const AuthInterceptor());

      // Make the POST request
      final response = await dio.put(
        EnvironmentKycConfig.kycVerifyCode + userId,
        data: code,
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

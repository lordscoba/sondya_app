import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/api_constants.dart';

class AuthUserNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  AuthUserNotifier() : super(const AsyncValue.data({}));

  Future<void> createUser(userData) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();
      final dio = Dio();

      // Make the POST request
      final response =
          await dio.post(EnvironmentAuthConfig.register, data: userData);
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

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sondya_app/data/api_constants.dart';
import 'package:sondya_app/data/storage_constants.dart';
import 'package:sondya_app/utils/auth_utils.dart';

class AuthUserNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  AuthUserNotifier() : super(const AsyncValue.data({}));

  Future<void> createUser(userData) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();
      final dio = Dio();

      // Make the POST request
      final response = await dio.post(
        EnvironmentAuthConfig.register,
        data: userData,
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

  Future<void> loginUser(userData) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();
      final dio = Dio();

      // Make the POST request
      final response = await dio.post(
        EnvironmentAuthConfig.login,
        data: userData,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        state = AsyncValue.data(response.data as Map<String, dynamic>);

        // store the login data in shared preferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        // await prefs.remove('loginR');
        await prefs.setString(EnvironmentStorageConfig.authSession,
            jsonEncode(getNecessaryAuthData(response.data["data"])));

        // final String? loginR = prefs.getString('loginR');
        // debugPrint(prefs.getString('loginR') ?? 'no data');
        // String detailsstring = jsonEncode(response.data);
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

  Future<void> forgotPassword(userData) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();
      final dio = Dio();

      // Make the POST request
      final response = await dio.post(
        EnvironmentAuthConfig.forgotPassword,
        data: userData,
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

  Future<void> verifyEmail(userData, String email) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();
      final dio = Dio();

      // Make the POST request
      final response = await dio.post(
        EnvironmentAuthConfig.verifyEmail + email,
        data: userData,
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

  Future<void> resetPassword(userData, String email) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();
      final dio = Dio();

      // Make the POST request
      final response = await dio.post(
        EnvironmentAuthConfig.resetPassword + email,
        data: userData,
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

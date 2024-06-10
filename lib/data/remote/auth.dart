import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sondya_app/data/api_constants.dart';
import 'package:sondya_app/data/hive_boxes.dart';
import 'package:sondya_app/data/storage_constants.dart';
import 'package:sondya_app/domain/hive_models/auth/auth.dart';
import 'package:sondya_app/domain/providers/auth.provider.dart';
import 'package:sondya_app/utils/auth_utils.dart';

// class AuthUserNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
//   AuthUserNotifier() : super(const AsyncValue.data({}));

//   Future<void> createUser(userData) async {
//     try {
//       // Set loading state
//       state = const AsyncValue.loading();
//       final dio = Dio();

//       // Make the POST request
//       final response = await dio.post(
//         EnvironmentAuthConfig.register,
//         data: userData,
//       );
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         state = AsyncValue.data(response.data as Map<String, dynamic>);
//       }
//     } on DioException catch (e) {
//       if (e.response != null) {
//         state = AsyncValue.error(e.response?.data['message'], e.stackTrace);
//         // debugPrint(e.response?.data['message'].toString());
//       } else {
//         state = AsyncValue.error(e.message.toString(), e.stackTrace);
//         // debugPrint(e.message.toString());
//       }
//     }
//   }

//   Future<void> loginUser(userData) async {
//     try {
//       // Set loading state
//       state = const AsyncValue.loading();
//       final dio = Dio();

//       // Make the POST request
//       final response = await dio.post(
//         EnvironmentAuthConfig.login,
//         data: userData,
//       );
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         state = AsyncValue.data(response.data as Map<String, dynamic>);

//         // store the login data in hive authBox
//         boxAuth.clear();
//         AuthInfo userInfo =
//             AuthInfo.fromJson(getNecessaryAuthData(response.data["data"]));
//         boxAuth.put(EnvironmentStorageConfig.authSession, userInfo);

//         // get the login data from hive authBox
//         // final AuthInfo authData =
//         //     boxAuth.get(EnvironmentStorageConfig.authSession) as AuthInfo;
//         // debugPrint(authData.toJson().toString());
//       }
//     } on DioException catch (e) {
//       if (e.response != null) {
//         state = AsyncValue.error(e.response?.data['message'], e.stackTrace);
//         // debugPrint(e.response?.data['message'].toString());
//       } else {
//         state = AsyncValue.error(e.message.toString(), e.stackTrace);
//         // debugPrint(e.message.toString());
//       }
//     }
//   }

//   Future<void> forgotPassword(userData) async {
//     try {
//       // Set loading state
//       state = const AsyncValue.loading();
//       final dio = Dio();

//       // Make the POST request
//       final response = await dio.post(
//         EnvironmentAuthConfig.forgotPassword,
//         data: userData,
//       );
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         state = AsyncValue.data(response.data as Map<String, dynamic>);
//       }
//     } on DioException catch (e) {
//       if (e.response != null) {
//         state = AsyncValue.error(e.response?.data['message'], e.stackTrace);
//         // debugPrint(e.response?.data['message'].toString());
//       } else {
//         state = AsyncValue.error(e.message.toString(), e.stackTrace);
//         // debugPrint(e.message.toString());
//       }
//     }
//   }

//   Future<void> verifyEmail(userData, String email) async {
//     try {
//       // Set loading state
//       state = const AsyncValue.loading();
//       final dio = Dio();

//       // Make the POST request
//       final response = await dio.post(
//         EnvironmentAuthConfig.verifyEmail + email,
//         data: userData,
//       );
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         state = AsyncValue.data(response.data as Map<String, dynamic>);
//       }
//     } on DioException catch (e) {
//       if (e.response != null) {
//         state = AsyncValue.error(e.response?.data['message'], e.stackTrace);
//         // debugPrint(e.response?.data['message'].toString());
//       } else {
//         state = AsyncValue.error(e.message.toString(), e.stackTrace);
//         // debugPrint(e.message.toString());
//       }
//     }
//   }

//   Future<void> resetPassword(userData, String email) async {
//     try {
//       // Set loading state
//       state = const AsyncValue.loading();
//       final dio = Dio();

//       // Make the POST request
//       final response = await dio.post(
//         EnvironmentAuthConfig.resetPassword + email,
//         data: userData,
//       );
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         state = AsyncValue.data(response.data as Map<String, dynamic>);
//       }
//     } on DioException catch (e) {
//       if (e.response != null) {
//         state = AsyncValue.error(e.response?.data['message'], e.stackTrace);
//         // debugPrint(e.response?.data['message'].toString());
//       } else {
//         state = AsyncValue.error(e.message.toString(), e.stackTrace);
//         // debugPrint(e.message.toString());
//       }
//     }
//   }

//   Future<void> logout() async {
//     try {
//       // Set loading state
//       state = const AsyncValue.loading();

//       // get box auth data and clear it
//       boxAuth.clear();
//       state = const AsyncValue.data({});
//     } on Exception catch (e) {
//       state = AsyncValue.error(e, StackTrace.current);
//     }
//   }
// }

class CreateUserNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  CreateUserNotifier() : super(const AsyncValue.data({}));

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
}

class LoginUserNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  LoginUserNotifier() : super(const AsyncValue.data({}));

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

        boxAuth = await Hive.openBox<AuthInfo>(authBoxString);
        // store the login data in hive authBox
        await boxAuth.clear();
        AuthInfo userInfo =
            AuthInfo.fromJson(getNecessaryAuthData(response.data["data"]));
        boxAuth.put(EnvironmentStorageConfig.authSession, userInfo);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        state = AsyncValue.error(e.response?.data['message'], e.stackTrace);
        // debugPrint(e.response?.data['message'].toString());
      } else {
        state = AsyncValue.error(e.message.toString(), e.stackTrace);
        // debugPrint(e.message.toString());
      }
    } finally {
      // Ensure the box is closed if it was opened
      await boxAuth.close();
    }
  }
}

class ForgotPasswordUserNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  ForgotPasswordUserNotifier() : super(const AsyncValue.data({}));

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
}

class VerifyEmailUserNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  VerifyEmailUserNotifier() : super(const AsyncValue.data({}));

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
}

class ResetPasswordUserNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  ResetPasswordUserNotifier() : super(const AsyncValue.data({}));

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

class LogoutUserNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  LogoutUserNotifier() : super(const AsyncValue.data({}));

  Future<void> logout(WidgetRef ref) async {
    Box<AuthInfo>? boxAuth;
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // Open the Hive box
      boxAuth = await Hive.openBox<AuthInfo>(authBoxString);

      // Update the authentication state
      ref.watch(isAuthenticatedTemp.notifier).state = false;

      // Clear the box
      await boxAuth.clear();

      // Set data to empty
      state = const AsyncValue.data({});
    } catch (e, stackTrace) {
      // Handle any errors
      state = AsyncValue.error(e, stackTrace);
    } finally {
      // Ensure the box is closed if it was opened
      await boxAuth?.close();
    }
  }
}


// class LogoutUserNotifier
//     extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
//   LogoutUserNotifier() : super(const AsyncValue.data({}));

//   Future<void> logout(WidgetRef ref) async {
//     try {
//       // Set loading state
//       state = const AsyncValue.loading();

//       final boxAuth = await Hive.openBox<AuthInfo>(authBoxString);

//       ref.watch(isAuthenticatedTemp.notifier).state = false;

//       // get box auth data and clear it
//       boxAuth.clear();

//       // Set data to empty
//       state = const AsyncValue.data({});
//     } on Exception catch (e) {
//       state = AsyncValue.error(e, StackTrace.current);
//     } finally {
//       boxAuth.close();
//     }
//   }
// }

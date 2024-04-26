import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:sondya_app/data/api_constants.dart';
import 'package:sondya_app/data/local/get_local_auth.dart';
import 'package:sondya_app/data/repositories/token_interceptors.dart';
import 'package:sondya_app/domain/models/user/kyc.dart';

class KycEmailNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  KycEmailNotifier() : super(const AsyncValue.data({}));

  Future<void> kycVerifyEmail(email) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // initialize dio and add interceptors
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
}

class KycCodeNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  KycCodeNotifier() : super(const AsyncValue.data({}));

  Future<void> kycVerifyCode(code) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // initialize dio and add interceptors
      final dio = Dio();
      dio.interceptors.add(const AuthInterceptor());

      // get auth user id
      Map<String, dynamic>? localAuth =
          await getLocalAuth() as Map<String, dynamic>;
      String? userId = localAuth["id"];

      final response = await dio.put(
        EnvironmentKycConfig.kycVerifyCode + userId!,
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

class KycPersonalInformationNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  KycPersonalInformationNotifier() : super(const AsyncValue.data({}));

  Future<void> kycPersonalDetails(details) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // initialize dio and add interceptors
      final dio = Dio();
      dio.interceptors.add(const AuthInterceptor());

      // get auth user id

      Map<String, dynamic>? localAuth =
          await getLocalAuth() as Map<String, dynamic>;
      String? userId = localAuth["id"];

      // Make the PUT request
      final response = await dio.put(
        EnvironmentKycConfig.kycPersonalDetails + userId!,
        data: details,
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

class KycContactInfoNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  KycContactInfoNotifier() : super(const AsyncValue.data({}));
  Future<void> kycContactInfo(details) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // initialize dio and add interceptors
      final dio = Dio();
      dio.interceptors.add(const AuthInterceptor());

      // get auth user id
      Map<String, dynamic>? localAuth =
          await getLocalAuth() as Map<String, dynamic>;
      String? userId = localAuth["id"];

      // Make the PUT request
      final response = await dio.put(
        EnvironmentKycConfig.kycContactInfo + userId!,
        data: details,
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

class KycDocumentUploadNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  KycDocumentUploadNotifier() : super(const AsyncValue.data({}));

  Future<void> kycDocumentUpload(KycDocumentFileType details) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // initialize dio and add interceptors
      final dio = Dio();
      dio.interceptors.add(const AuthInterceptor());

      // get auth user id
      Map<String, dynamic>? localAuth =
          await getLocalAuth() as Map<String, dynamic>;
      String? userId = localAuth["id"];

      // check file mime type and set form data
      final mimeTypeData = lookupMimeType(details.image!.path);
      final formData = FormData.fromMap(
        {
          ...details.toJson(),
          'image': await MultipartFile.fromFile(details.image!.path,
              filename: details.image!.name,
              contentType:
                  MediaType('image', mimeTypeData!.split('/').last.toString())),
        },
      );

      // Make the PUT request
      final response = await dio.put(
        EnvironmentKycConfig.kycDocumentUpload + userId!,
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

class KycProfilePicsNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  KycProfilePicsNotifier() : super(const AsyncValue.data({}));

  Future<void> kycProfilePics(details) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // initialize dio and add interceptors
      final dio = Dio();
      dio.interceptors.add(const AuthInterceptor());

      // get auth user id
      Map<String, dynamic>? localAuth =
          await getLocalAuth() as Map<String, dynamic>;
      String? userId = localAuth["id"];

      // check file mime type and set form data
      final mimeTypeData = lookupMimeType(details.image!.path);
      final formData = FormData.fromMap(
        {
          ...details.toJson(),
          'image': await MultipartFile.fromFile(details.image!.path,
              filename: details.image!.name,
              contentType:
                  MediaType('image', mimeTypeData!.split('/').last.toString())),
        },
      );

      // Make the PUT request
      final response = await dio.put(
        EnvironmentKycConfig.kycProfilePicture + userId!,
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

class KycCompanyInfoNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  KycCompanyInfoNotifier() : super(const AsyncValue.data({}));

  Future<void> kycCompanyDetails(details) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // initialize dio and add interceptors
      final dio = Dio();
      dio.interceptors.add(const AuthInterceptor());

      // get auth user id
      Map<String, dynamic>? localAuth =
          await getLocalAuth() as Map<String, dynamic>;
      String? userId = localAuth["id"];

      // Make the PUT request
      final response = await dio.put(
        EnvironmentKycConfig.kycCompanyDetails + userId!,
        data: details,
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

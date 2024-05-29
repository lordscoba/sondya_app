import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/api_constants.dart';
import 'package:sondya_app/data/local/get_local_auth.dart';
import 'package:sondya_app/data/repositories/token_interceptors.dart';
import 'package:sondya_app/domain/hive_models/auth/auth.dart';

final getChatsProvider = FutureProvider.autoDispose<List<dynamic>>((ref) async {
  try {
    final dio = Dio();
    dio.interceptors.add(const AuthInterceptor());

    // get auth user id
    AuthInfo localAuth = await getLocalAuth();
    String userId = localAuth.id;

    final response = await dio.get(EnvironmentChatConfig.getChats + userId);
    // debugPrint(response.data.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print(response.data["data"]);
      return response.data["data"] as List<dynamic>;
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

typedef ChatParameters = ({String senderId, String receiverId});

final getChatProvider = FutureProvider.autoDispose
    .family<Map<String, dynamic>, ChatParameters>((ref, arguments) async {
  try {
    final dio = Dio();
    dio.interceptors.add(const AuthInterceptor());

    // // get auth user id
    // AuthInfo localAuth = await getLocalAuth();
    // String userId = localAuth.id;

    final response = await dio.get(
        "${EnvironmentChatConfig.getChat}?sender_id=${arguments.senderId}&receiver_id=${arguments.receiverId}");

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

final getMessagesProvider = FutureProvider.autoDispose
    .family<List<dynamic>, ChatParameters>((ref, arguments) async {
  try {
    final dio = Dio();
    dio.interceptors.add(const AuthInterceptor());

    // // get auth user id
    // AuthInfo localAuth = await getLocalAuth();
    // String userId = localAuth.id;

    final response = await dio.get(
        "${EnvironmentChatConfig.getMessages}?sender_id=${arguments.senderId}&receiver_id=${arguments.receiverId}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      // debugPrint(response.data["data"].toString());

      return response.data["data"] as List<dynamic>;
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

class PostMessagesNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  PostMessagesNotifier() : super(const AsyncValue.data({}));
  Future<void> postMessages(data) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // initialize dio and add interceptors
      final dio = Dio();
      dio.interceptors.add(const AuthInterceptor());

      // Make the PUT request
      final response = await dio.post(
        EnvironmentChatConfig.sendMessage,
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

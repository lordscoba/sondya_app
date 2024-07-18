import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/api_constants.dart';
import 'package:sondya_app/data/local/get_local_auth.dart';
import 'package:sondya_app/data/repositories/token_interceptors.dart';
import 'package:sondya_app/domain/hive_models/auth/auth.dart';

// final getUserGroupchatsProvider = FutureProvider.autoDispose
//     .family<List<Map<String, dynamic>>, String>((ref, id) async {
//   try {
//     final dio = Dio();
//     dio.interceptors.add(const AuthInterceptor());

//     final response =
//         await dio.get("${EnvironmentGroupChatConfig.getUserGroupChats}/$id");
//     if (response.statusCode == 200) {
//       return response.data as List<Map<String, dynamic>>;
//     } else {
//       throw Exception('Failed to fetch map data');
//     }
//   } on DioException catch (e) {
//     if (e.response != null) {
//       // debugPrint(e.response?.data.toString());
//       return e.response?.data;
//     } else {
//       // debugPrint(e.message.toString());
//       return throw Exception("Failed to fetch map data error: ${e.message}");
//     }
//   }
// });

final getGroupchatsProvider = FutureProvider.autoDispose
    .family<List<dynamic>, String>((ref, search) async {
  try {
    final dio = Dio();
    dio.interceptors.add(const AuthInterceptor());

    final response =
        await dio.get(EnvironmentGroupChatConfig.getChats + search);

    // get auth user id
    AuthInfo localAuth = await getLocalAuth();
    String userId = localAuth.id;

    // get user group chats that user has joined
    final response2 =
        await dio.get("${EnvironmentGroupChatConfig.getUserGroupChats}$userId");

    List userGroupChatsList = [];

    // get list of user group chats
    response2.data["data"].forEach((element) {
      userGroupChatsList.add(element["group_id"]);
    });

    // get list of group chats
    List<dynamic> groupChatsList = response.data["data"]["groupChats"];

    // check if user has joined and mark it as isJoined == true
    for (var element in groupChatsList) {
      if (userGroupChatsList.contains(element["_id"])) {
        element["isJoined"] = true;
      } else {
        element["isJoined"] = false;
      }
    }

    if (response.statusCode == 200) {
      return groupChatsList;
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

final getGroupchatProvider = FutureProvider.autoDispose
    .family<Map<String, dynamic>, String>((ref, id) async {
  try {
    final dio = Dio();
    dio.interceptors.add(const AuthInterceptor());

    final response = await dio.get("${EnvironmentGroupChatConfig.getChat}/$id");
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

final getGroupchatMembersProvider = FutureProvider.autoDispose
    .family<List<Map<String, dynamic>>, String>((ref, groupId) async {
  try {
    final dio = Dio();
    dio.interceptors.add(const AuthInterceptor());

    final response =
        await dio.get("${EnvironmentGroupChatConfig.getMembers}/$groupId");
    if (response.statusCode == 200) {
      return response.data as List<Map<String, dynamic>>;
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

final getGroupchatMessagesProvider = FutureProvider.autoDispose
    .family<List<Map<String, dynamic>>, String>((ref, groupId) async {
  try {
    final dio = Dio();
    dio.interceptors.add(const AuthInterceptor());

    final response =
        await dio.get("${EnvironmentGroupChatConfig.getMessages}/$groupId");
    if (response.statusCode == 200) {
      return response.data as List<Map<String, dynamic>>;
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

class MemberJoinGroupChatNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  MemberJoinGroupChatNotifier() : super(const AsyncValue.data({}));

  Future<void> joinChat(groupId) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // initialize dio and add interceptors
      final dio = Dio();
      dio.interceptors.add(const AuthInterceptor());

      // get auth user id
      AuthInfo localAuth = await getLocalAuth();
      String userId = localAuth.id;

      // Make the PUT request
      final response = await dio.post(
        EnvironmentGroupChatConfig.joinChat,
        data: {"user_id": userId, "group_id": groupId},
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

class SendMessageGroupChatNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  SendMessageGroupChatNotifier() : super(const AsyncValue.data({}));

  Future<void> sendMessage(details) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // initialize dio and add interceptors
      final dio = Dio();
      dio.interceptors.add(const AuthInterceptor());

      // // get auth user id
      // AuthInfo localAuth = await getLocalAuth();
      // String userId = localAuth.id;

      // Make the PUT request
      final response = await dio.post(
        EnvironmentGroupChatConfig.sendMessage,
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

class ToggleLikeButtonGroupChatNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  ToggleLikeButtonGroupChatNotifier() : super(const AsyncValue.data({}));

  Future<void> toggleLikeButton(details) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      // initialize dio and add interceptors
      final dio = Dio();
      dio.interceptors.add(const AuthInterceptor());

      // // get auth user id
      // AuthInfo localAuth = await getLocalAuth();
      // String userId = localAuth.id;

      // Make the PUT request
      final response = await dio.post(
        EnvironmentGroupChatConfig.likeMessage,
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

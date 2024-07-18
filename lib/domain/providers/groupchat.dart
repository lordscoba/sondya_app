import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/groupchat.dart';
import 'package:sondya_app/domain/models/home.dart';

final groupchatSearchprovider =
    StateProvider<ProductSearchModel>((ref) => ProductSearchModel());

final toggleLikeButtonGroupChatProvider = StateNotifierProvider.autoDispose<
    ToggleLikeButtonGroupChatNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return ToggleLikeButtonGroupChatNotifier();
});

final sendMessageGroupChatProvider = StateNotifierProvider.autoDispose<
    SendMessageGroupChatNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return SendMessageGroupChatNotifier();
});

final memberJoinGroupChatProvider = StateNotifierProvider.autoDispose<
    MemberJoinGroupChatNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return MemberJoinGroupChatNotifier();
});

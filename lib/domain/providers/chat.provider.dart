import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/chat.dart';

final postMessagesProvider = StateNotifierProvider.autoDispose<
    PostMessagesNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return PostMessagesNotifier();
});

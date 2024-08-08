import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/notifications.dart';

final createNotificationsProvider = StateNotifierProvider.autoDispose<
    CreateNotificationsNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return CreateNotificationsNotifier();
});

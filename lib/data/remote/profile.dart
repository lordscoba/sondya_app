import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  ProfileNotifier() : super(const AsyncValue.data({}));
}

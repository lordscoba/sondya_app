import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/hive_boxes.dart';
import 'package:sondya_app/data/storage_constants.dart';

class HasInitAppNotifier extends StateNotifier<AsyncValue<bool>> {
  HasInitAppNotifier() : super(const AsyncValue.data(false));

  Future<void> update1(bool status) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      await boxHasInitializedApp.put(
          EnvironmentStorageConfig.hasInitializedAppSession, status);
      state = AsyncValue.data(status);
    } on Error catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}

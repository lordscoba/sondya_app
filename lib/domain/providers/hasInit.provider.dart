import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/local/has_init_app.dart';

final hasInitAppProvider =
    StateNotifierProvider.autoDispose<HasInitAppNotifier, AsyncValue<bool>>(
        (ref) {
  return HasInitAppNotifier();
});

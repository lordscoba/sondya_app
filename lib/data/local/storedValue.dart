import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/hive_boxes.dart';
import 'package:sondya_app/data/storage_constants.dart';
import 'package:sondya_app/domain/hive_models/auth.dart';

final storedAuthValueProvider =
    FutureProvider.autoDispose<AuthInfo>((ref) async {
  return boxAuth.get(EnvironmentStorageConfig.authSession);
});

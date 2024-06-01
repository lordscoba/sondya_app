import 'package:sondya_app/data/hive_boxes.dart';
import 'package:sondya_app/data/storage_constants.dart';

bool hasInitializedAppSession() {
  final bool? obj = boxHasInitializedApp
      .get(EnvironmentStorageConfig.hasInitializedAppSession);
  return obj ?? false;
}

import 'package:sondya_app/data/hive_boxes.dart';
import 'package:sondya_app/data/storage_constants.dart';

bool isSellerSession() {
  final bool? obj = boxIsSeller.get(EnvironmentStorageConfig.isSellerSession);

  // // Check if obj is null
  // if (obj == null) {
  //   return false;
  // }

  // // check if obj is empty
  // if (obj.toString().isEmpty) {
  //   return false;
  // }
  return obj ?? false;
}

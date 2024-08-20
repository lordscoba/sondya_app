import 'package:sondya_app/data/hive_boxes.dart';
import 'package:sondya_app/data/storage_constants.dart';

bool isSellerSession() {
  final bool? obj = boxIsSeller.get(EnvironmentStorageConfig.isSellerSession);
  return obj ?? false;
}

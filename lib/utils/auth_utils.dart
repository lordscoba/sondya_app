import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sondya_app/data/hive_boxes.dart';
import 'package:sondya_app/data/storage_constants.dart';
import 'package:sondya_app/domain/hive_models/auth/auth.dart';

// get necessary auth data data in map form
Map<String, dynamic> getNecessaryAuthData(Map<String, dynamic> response) {
  Map<String, dynamic> newMap = {};

  Map<String, dynamic> decodedToken = JwtDecoder.decode(response["token"]);

  response.forEach((key, value) {
    newMap[key] = value.toString();
  });
  decodedToken.forEach((key, value) {
    if (key != 'iat' && key != 'exp') newMap[key] = value;
  });

  return newMap;
}

// check if user is authenticated
bool isAuthenticated() {
  final AuthInfo? obj = boxAuth.get(EnvironmentStorageConfig.authSession);

  // Check if obj is null
  if (obj == null) {
    return false;
  }

  // check if obj is empty
  if (obj.toJson().isEmpty) {
    return false;
  }

  //check if token is empty
  if (obj.token.isEmpty) {
    return false;
  }

  // check if token is expired
  if (JwtDecoder.isExpired(obj.token)) {
    return false;
  }

  return true;
}

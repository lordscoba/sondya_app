import 'package:jwt_decoder/jwt_decoder.dart';

Map<String, dynamic> getNecessaryAuthData(Map<String, dynamic> response) {
  Map<String, dynamic> newMap = {};

  Map<String, dynamic> decodedToken = JwtDecoder.decode(response["token"]);

  response.forEach((key, value) {
    newMap[key] = value;
  });
  decodedToken.forEach((key, value) {
    if (key != 'iat' && key != 'exp') newMap[key] = value;
  });

  return newMap;
}

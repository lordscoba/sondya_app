import 'package:hive/hive.dart';
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

Future<bool> isAuthenticated() async {
  // Open the Hive box only once for performance optimization
  boxAuth = await Hive.openBox<AuthInfo>(authBoxString);

  try {
    // Attempt to retrieve the AuthInfo object
    final AuthInfo? obj =
        await boxAuth.get(EnvironmentStorageConfig.authSession);

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
  } on HiveError catch (error) {
    print(error);
    return false;
  } catch (error) {
    print(error);
    return false;
  } finally {
    // await boxAuth.close();
  }
}

Future<bool> isKycCompleted() async {
  // Open the Hive box only once for performance optimization
  boxAuth = await Hive.openBox<AuthInfo>(authBoxString);

  try {
    // Attempt to retrieve the AuthInfo object
    final AuthInfo? obj =
        await boxAuth.get(EnvironmentStorageConfig.authSession);

    if (obj == null || obj.toJson().isEmpty || obj.token.isEmpty) {
      return false;
    }

    // check if kyc is completed
    if (obj.kycCompleted != "true") {
      return false;
    }

    return true;
  } on HiveError catch (error) {
    print(error);
    return false;
  } catch (error) {
    print(error);
    return false;
  } finally {
    await boxAuth.close();
  }
}

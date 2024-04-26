import 'package:sondya_app/data/hive_boxes.dart';
import 'package:sondya_app/data/storage_constants.dart';
import 'package:sondya_app/domain/hive_models/auth.dart';

Future<AuthInfo> getLocalAuth() async {
  if (boxAuth.isEmpty) {
    return AuthInfo(
        type: '',
        token: '',
        emailVerified: '',
        kycCompleted: '',
        id: '',
        email: '',
        username: '');
  } else {
    return boxAuth.get(EnvironmentStorageConfig.authSession) ?? {};
  }
}

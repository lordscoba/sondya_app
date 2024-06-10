import 'package:hive/hive.dart';
import 'package:sondya_app/data/hive_boxes.dart';
import 'package:sondya_app/data/storage_constants.dart';
import 'package:sondya_app/domain/hive_models/auth/auth.dart';

Future<AuthInfo> getLocalAuth() async {
  boxAuth = await Hive.openBox<AuthInfo>(authBoxString);
  try {
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
      return await boxAuth.get(EnvironmentStorageConfig.authSession)!;
    }
  } on HiveError catch (error) {
    print(error);

    return AuthInfo(
        type: '',
        token: '',
        emailVerified: '',
        kycCompleted: '',
        id: '',
        email: '',
        username: '');
  } catch (error) {
    print(error);
    return AuthInfo(
        type: '',
        token: '',
        emailVerified: '',
        kycCompleted: '',
        id: '',
        email: '',
        username: '');
  } finally {
    await boxAuth.close();
  }
}

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:sondya_app/data/hive_boxes.dart';
import 'package:sondya_app/data/storage_constants.dart';
import 'package:sondya_app/domain/hive_models/auth/auth.dart';

class AuthInterceptor extends Interceptor {
  const AuthInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    boxAuth = await Hive.openBox<AuthInfo>(authBoxString);
    // // Get the token from the box
    final AuthInfo? obj =
        await boxAuth.get(EnvironmentStorageConfig.authSession);

    options.headers = {
      ...options.headers,
      "Authorization": "Bearer ${obj?.token}",
    };

    await boxAuth.close();
    super.onRequest(options, handler);
  }
}

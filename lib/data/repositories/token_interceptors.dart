import 'package:dio/dio.dart';
import 'package:sondya_app/data/hive_boxes.dart';
import 'package:sondya_app/data/storage_constants.dart';
import 'package:sondya_app/domain/hive_models/auth/auth.dart';

class AuthInterceptor extends Interceptor {
  const AuthInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // // Get the token from the box
    final AuthInfo obj = boxAuth.get(EnvironmentStorageConfig.authSession);

    options.headers = {
      ...options.headers,
      "Authorization": "Bearer ${obj.token}",
    };
    super.onRequest(options, handler);
  }
}

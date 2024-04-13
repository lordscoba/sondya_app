import 'package:dio/dio.dart';

class FormDataHeaderInterceptor extends Interceptor {
  const FormDataHeaderInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Set content type
    options.headers = {
      ...options.headers,
      "Content-Type": "multipart/form-data",
    };
    super.onRequest(options, handler);
  }
}

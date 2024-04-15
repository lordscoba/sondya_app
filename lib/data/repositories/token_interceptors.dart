import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  const AuthInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // // Get the token
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    // final String? data = prefs.getString(EnvironmentStorageConfig.authSession);
    // Map<String, dynamic>? dataMap = jsonDecode(data!);

    // if (dataMap != null) {
    //   options.headers = {
    //     ...options.headers,
    //     "Authorization": "Bearer ${dataMap["token"]}",
    //   };
    // }

    options.headers = {
      ...options.headers,
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1YTEwYTY2ZGY4MDUxNTAzNzY2YjIyNyIsImVtYWlsIjoiZTJzY29iYTJ0bUBnbWFpbC5jb20iLCJ0eXBlIjoidXNlciIsInVzZXJuYW1lIjoiZTJzY29iYSIsImlhdCI6MTcxMzE3MzA5NCwiZXhwIjoxNzEzMjU5NDk0fQ.WuMNA6h38-WOYKguOg12gnFh2pn4zHbgl6GU7ab7OSk",
    };
    super.onRequest(options, handler);
  }
}

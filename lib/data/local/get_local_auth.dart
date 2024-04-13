import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sondya_app/data/storage_constants.dart';

Future<Map<String, dynamic>> getLocalAuth() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String data =
      prefs.getString(EnvironmentStorageConfig.authSession) ?? '';
  final dataJson = jsonDecode(_correctJsonString(data)) as Map<String, dynamic>;
  if (data == '') {
    return {};
  } else {
    return dataJson;
  }
}

String _correctJsonString(String jsonString) {
  // Add double quotes around keys and string values
  return jsonString.replaceAllMapped(
    RegExp(r'"?(\b\w+\b)"?: ("?.*?"?)(,|\s*(?=}))'),
    (match) {
      final key = match.group(1);
      final value = match.group(2);
      return '"$key": "$value"${match.group(3) ?? ''}';
    },
  );
}

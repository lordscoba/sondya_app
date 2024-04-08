import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final storedValueProvider =
    FutureProvider.family.autoDispose<String, String>((ref, key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString(key) ?? '';
});

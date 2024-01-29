import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

FutureOr<List<T>> loadJsonAsset<T>(String filePath) async {
  try {
    final String response = await rootBundle.loadString(filePath);
    final List<T> parsedData = jsonDecode(response);
    return parsedData;
  } catch (e) {
    debugPrint("Error reading JSON file from assets: $e");
  }
  return [];
}

Future<void> loadJsonLocal() async {
  try {
    final file = File('path/to/your/file.json');
    final contents = await file.readAsString();
    final parsedData = jsonDecode(contents);
    // Use the parsed data here
    debugPrint(parsedData);
  } catch (e) {
    debugPrint("Error reading JSON file: $e");
  }
}

import 'dart:convert';

void printFullText(String text) {
  final pattern =
      RegExp('.{1,800}'); // 800 is the maximum length per print statement
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

void printPrettyJson(Map<String, dynamic> json) {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  String prettyJson = encoder.convert(json);
  printFullText(prettyJson);
}

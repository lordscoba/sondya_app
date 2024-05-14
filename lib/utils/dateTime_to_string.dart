import 'package:intl/intl.dart';

String sondyaFormattedDate(String dateTimeString, {bool includeTime = true}) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedDate = "";
  if (includeTime) {
    formattedDate = DateFormat.yMMMd().add_jm().format(dateTime);
  } else {
    formattedDate = DateFormat.yMMMd().format(dateTime);
  }

  // formattedDate = DateFormat("yyyy-MM-dd").format(dateTime);

  return formattedDate;
}

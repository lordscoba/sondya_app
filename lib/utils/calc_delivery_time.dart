import 'package:intl/intl.dart';

String calculateDeliveryTime({
  required String durationUnit,
  required int duration,
}) {
  final DateTime currentDate = DateTime.now();

  final double conversionValue = durationUnit == 'weeks'
      ? 6.048e8
      : durationUnit == 'days'
          ? 8.64e7
          : durationUnit == 'months'
              ? 2.628e9
              : 3.6e6; // last one is hours

  final DateTime deliveryDateTime = currentDate
      .add(Duration(milliseconds: (duration * conversionValue).toInt()));

  // Format the date to "Tue, 16 Jan 2024 19:56:07 GMT"
  final DateFormat formatter = DateFormat('EEE, dd MMM yyyy HH:mm:ss');
  final String formattedDate = formatter.format(deliveryDateTime.toUtc());

  return '$formattedDate GMT';
}

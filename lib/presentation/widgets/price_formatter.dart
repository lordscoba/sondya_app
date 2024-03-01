import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceFormatWidget extends StatelessWidget {
  final double price;
  final String currencySymbol;
  final int decimalDigits;

  const PriceFormatWidget({
    super.key,
    required this.price,
    this.currencySymbol = '\$', // Default currency symbol
    this.decimalDigits = 2, // Default decimal digits
  });

  @override
  Widget build(BuildContext context) {
    final formattedPrice = NumberFormat.currency(
      decimalDigits: decimalDigits,
      symbol: currencySymbol,
    ).format(price);

    return Text(
      formattedPrice,
      style: const TextStyle(
        fontSize: 12.0, // Adjust as desired
        fontWeight: FontWeight.bold, // Adjust as desired
        color: Color(0xFFEDB842),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceFormatWidget extends StatelessWidget {
  final double price;
  final String currencySymbol;
  final int decimalDigits;
  final bool oldPrice;
  final double fontSize;

  const PriceFormatWidget({
    super.key,
    required this.price,
    this.currencySymbol = '\$', // Default currency symbol
    this.decimalDigits = 2, // Default decimal digits
    this.oldPrice = false,
    this.fontSize = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    final formattedPrice = NumberFormat.currency(
      decimalDigits: decimalDigits,
      symbol: currencySymbol,
    ).format(price);

    return Text(
      formattedPrice,
      style: TextStyle(
        decoration: oldPrice ? TextDecoration.lineThrough : TextDecoration.none,
        fontSize: fontSize, // Adjust as desired
        fontWeight:
            oldPrice ? FontWeight.normal : FontWeight.bold, // Adjust as desired
        color: oldPrice ? const Color(0xFF77878F) : const Color(0xFFEDB842),
      ),
    );
  }
}

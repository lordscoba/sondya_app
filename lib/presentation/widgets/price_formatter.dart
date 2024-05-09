import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PriceFormatWidget extends StatelessWidget {
  final double price;
  final String currencySymbol;
  final int decimalDigits;
  final bool oldPrice;
  final double fontSize;
  final int priceMultiple;
  final String prefix;
  final String suffix;
  final String? fontFamily;
  final Color? color;

  const PriceFormatWidget({
    super.key,
    required this.price,
    this.currencySymbol = '\$', // Default currency symbol
    this.decimalDigits = 2, // Default decimal digits
    this.oldPrice = false,
    this.fontSize = 12.0,
    this.priceMultiple = 1,
    this.prefix = '',
    this.suffix = '',
    this.fontFamily,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final formattedPrice = NumberFormat.currency(
      decimalDigits: decimalDigits,
      symbol: currencySymbol,
    ).format(price * priceMultiple);

    return Text(
      prefix + formattedPrice + suffix,
      style: TextStyle(
        decoration: oldPrice ? TextDecoration.lineThrough : TextDecoration.none,
        fontSize: fontSize, // Adjust as desired
        fontWeight:
            oldPrice ? FontWeight.normal : FontWeight.bold, // Adjust as desired
        color: oldPrice
            ? const Color(0xFF77878F)
            : color ?? const Color(0xFFEDB842),
        fontFamily: fontFamily ?? GoogleFonts.playfairDisplay().fontFamily,
      ),
    );
  }
}

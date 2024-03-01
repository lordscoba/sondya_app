import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';

class ProductContainer extends StatelessWidget {
  final String productName;
  final double productPrice;
  final String productImage;
  const ProductContainer(
      {super.key,
      required this.productName,
      required this.productPrice,
      required this.productImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: 190,
      height: 190,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (productImage == "")
            Image(
              image: AssetImage(productImage),
              fit: BoxFit.contain,
              height: 120,
              width: double.infinity,
            )
          else
            Image(
              image: NetworkImage(productImage),
              fit: BoxFit.contain,
              height: 120,
              width: double.infinity,
            ),
          Text(
            productName,
            style: GoogleFonts.playfairDisplay(
                fontSize: 15, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          PriceFormatWidget(price: productPrice)
        ],
      ),
    );
  }
}

class ServiceContainer extends StatelessWidget {
  final String productName;
  final double productPrice;
  final String productImage;
  const ServiceContainer(
      {super.key,
      required this.productName,
      required this.productPrice,
      required this.productImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: 190,
      height: 190,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (productImage == "")
            Image(
              image: AssetImage(productImage),
              fit: BoxFit.contain,
              height: 120,
              width: double.infinity,
            )
          else
            Image(
              image: NetworkImage(productImage),
              fit: BoxFit.contain,
              height: 120,
              width: double.infinity,
            ),
          Text(
            productName,
            style: GoogleFonts.playfairDisplay(
                fontSize: 15, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          PriceFormatWidget(price: productPrice),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCheckoutItem extends ConsumerStatefulWidget {
  final int? quantity;
  final String? name;
  final double? price;
  final String? imageString;

  const ProductCheckoutItem({
    super.key,
    this.quantity,
    this.name,
    this.price,
    this.imageString,
  });

  @override
  ConsumerState<ProductCheckoutItem> createState() =>
      _ProductCheckoutItemState();
}

class _ProductCheckoutItemState extends ConsumerState<ProductCheckoutItem> {
  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      height: 140,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                  image: AssetImage("assets/shapes/circle_25.png"),
                  height: 100),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 250,
                child: Text(
                  "Gaming Keyboard and Mouse 3 Years Warranty",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
              ),
              Text(
                "\$ 4,000",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: GoogleFonts.openSans().fontFamily,
                ),
              ),
              Text(
                "Quantity: 3",
                style: TextStyle(
                    fontFamily: GoogleFonts.openSans().fontFamily,
                    fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

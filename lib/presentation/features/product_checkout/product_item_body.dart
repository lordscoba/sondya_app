import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sondya_app/data/remote/checkout.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';
import 'package:sondya_app/utils/slugify.dart';

class ProductCheckoutItem extends ConsumerStatefulWidget {
  final String? id;
  final int? quantity;
  final String? name;

  const ProductCheckoutItem({
    super.key,
    this.id,
    this.quantity,
    this.name,
  });

  @override
  ConsumerState<ProductCheckoutItem> createState() =>
      _ProductCheckoutItemState();
}

class _ProductCheckoutItemState extends ConsumerState<ProductCheckoutItem> {
  @override
  @override
  Widget build(BuildContext context) {
    final getProductDetails = ref.watch(getCheckoutProductDetailsProvider(
        (id: widget.id!, name: sondyaSlugify(widget.name!))));
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      height: 140,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
      ),
      child: getProductDetails.when(
        data: (data) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    image: NetworkImage(
                      data['data']["image"][0]["url"] == ""
                          ? "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"
                          : data['data']["image"][0]["url"],
                    ),
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250,
                    child: Text(
                      data['data']['name'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                  ),
                  PriceFormatWidget(
                    price: data['data']['current_price'].toDouble(),
                    fontSize: 20,
                    fontFamily: GoogleFonts.openSans().fontFamily,
                    color: Colors.black87,
                  ),
                  Text(
                    "Quantity: ${widget.quantity}",
                    style: TextStyle(
                        fontFamily: GoogleFonts.openSans().fontFamily,
                        fontSize: 16),
                  ),
                ],
              ),
            ],
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}

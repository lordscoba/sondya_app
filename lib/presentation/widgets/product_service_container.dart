import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sondya_app/data/local/cart.dart';
import 'package:sondya_app/domain/providers/cart.provider.dart';
import 'package:sondya_app/domain/providers/wishlist.provider.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';
import 'package:sondya_app/utils/slugify.dart';

class ProductContainer extends ConsumerStatefulWidget {
  final String id;
  final String productName;
  final double productPrice;
  final String productImage;
  const ProductContainer(
      {super.key,
      required this.productName,
      required this.productPrice,
      required this.productImage,
      required this.id});

  @override
  ConsumerState<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends ConsumerState<ProductContainer> {
  var isFavorite = false;
  void _detailsPage() {
    // debugPrint("/product/details/$id/${sondyaSlugify(productName)}");
    context.push(
        "/product/details/${widget.id}/${sondyaSlugify(widget.productName)}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _detailsPage,
      child: Container(
        width: 190,
        height: 250,
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.productImage == "")
              Image(
                image: AssetImage(widget.productImage),
                fit: BoxFit.contain,
                height: 120,
                width: double.infinity,
              )
            else
              Image(
                image: NetworkImage(widget.productImage),
                fit: BoxFit.contain,
                height: 120,
                width: double.infinity,
              ),
            Text(
              widget.productName,
              style: GoogleFonts.playfairDisplay(
                  fontSize: 15, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Container(
              height: 18,
              padding: EdgeInsets.zero,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PriceFormatWidget(price: widget.productPrice),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                        if (isFavorite) {
                          ref
                              .read(addToWishlistProvider.notifier)
                              .addToWishlist(
                                  widget.id, "product", widget.productName);
                        } else {
                          ref
                              .read(removeFromWishlistProvider.notifier)
                              .removeFromWishlist(widget.id, "product");
                        }
                      });
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_outline,
                      size: 15,
                      color: const Color(0xFFEDB842),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await ref.read(addToCartProvider.notifier).addToCart({
                    "_id": widget.id,
                    "order_quantity": 1,
                    "name": widget.productName
                  });
                  // ignore: unused_result
                  ref.refresh(getCartDataProvider);
                  // ignore: unused_result
                  ref.refresh(getTotalCartProvider);
                },
                child: const Text("Add to Cart"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ServiceContainer extends StatelessWidget {
  final String id;
  final String productName;
  final double productPrice;
  final String productImage;
  const ServiceContainer(
      {super.key,
      required this.productName,
      required this.productPrice,
      required this.productImage,
      required this.id});

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

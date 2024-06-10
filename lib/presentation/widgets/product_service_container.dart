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
    final route =
        "/product/details/${widget.id}/${sondyaSlugify(widget.productName)}";
    context.push(route);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _detailsPage,
      onLongPress: _detailsPage,
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
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PriceFormatWidget(
                    price: widget.productPrice,
                    fontSize: 15.0,
                  ),
                  SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 30,
                          child: IconButton(
                            onPressed: _detailsPage,
                            icon: const Icon(
                              Icons.visibility_outlined,
                              size: 18,
                              color: Color(0xFFEDB842),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                isFavorite = !isFavorite;
                                if (isFavorite) {
                                  ref
                                      .read(addToWishlistProvider.notifier)
                                      .addToWishlist(widget.id, "product",
                                          widget.productName);
                                } else {
                                  ref
                                      .read(removeFromWishlistProvider.notifier)
                                      .removeFromWishlist(widget.id, "product");
                                }
                              });
                            },
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              size: 18,
                              color: const Color(0xFFEDB842),
                            ),
                          ),
                        ),
                      ],
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

class ServiceContainer extends ConsumerStatefulWidget {
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
  ConsumerState<ServiceContainer> createState() => _ServiceContainerState();
}

class _ServiceContainerState extends ConsumerState<ServiceContainer> {
  var isFavorite = false;

  void _detailsPage() {
    context.push(
        "/service/details/${widget.id}/${sondyaSlugify(widget.productName)}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _detailsPage,
      onLongPress: _detailsPage,
      child: Container(
        padding: const EdgeInsets.all(5),
        width: 190,
        height: 250,
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
              maxLines: 1,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PriceFormatWidget(price: widget.productPrice),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                      if (isFavorite) {
                        ref.read(addToWishlistProvider.notifier).addToWishlist(
                            widget.id, "service", widget.productName);
                      } else {
                        ref
                            .read(removeFromWishlistProvider.notifier)
                            .removeFromWishlist(widget.id, "service");
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
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _detailsPage,
                child: const Text("Order"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

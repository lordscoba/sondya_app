import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sondya_app/data/app_constants.dart';
import 'package:sondya_app/data/local/cart.dart';
import 'package:sondya_app/data/remote/home.dart';
import 'package:sondya_app/domain/providers/cart.provider.dart';
import 'package:sondya_app/domain/providers/wishlist.provider.dart';
import 'package:sondya_app/presentation/features/product_details/product_details_tab.dart';
import 'package:sondya_app/presentation/features/product_details/review_section.dart';
import 'package:sondya_app/presentation/widgets/picture_slider.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';
import 'package:sondya_app/presentation/widgets/ratings_widget.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/utils/copy.dart';
import 'package:sondya_app/utils/slugify.dart';

class ProductDetailsBody extends ConsumerStatefulWidget {
  final String id;
  final String name;
  const ProductDetailsBody({super.key, required this.id, required this.name});

  @override
  ConsumerState<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends ConsumerState<ProductDetailsBody> {
  int _quantity = 0;
  var isFavorite = false;

  final TextStyle textStyleTax = const TextStyle(
    color: Colors.grey,
    fontSize: 13,
    fontWeight: FontWeight.w300,
  );

  @override
  Widget build(BuildContext context) {
    final getCartDataById = ref.watch(getCartDataByIdProvider(widget.id));
    getCartDataById.whenData((data) {
      _quantity = data.orderQuantity;
    });

    final TextEditingController quantityController =
        TextEditingController(text: _quantity.toString());

    final getProductDetails = ref
        .watch(getProductDetailsProvider((id: widget.id, name: widget.name)));
    final getProductRatingStat =
        ref.watch(getReviewStatsProvider((category: "product", id: widget.id)));

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Container(
          height: 2300,
          padding: const EdgeInsets.all(10),
          child: getProductDetails.when(
            data: (data) {
              // debugPrint(data["data"].toString());
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      IconButton(
                          iconSize: 30,
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(Icons.arrow_back))
                    ],
                  ),
                  data["data"]?["image"]?.isNotEmpty &&
                          data["data"]?["image"] != null
                      ? SondyaPictureSlider(
                          pictureList: data["data"]["image"],
                        )
                      : Container(),
                  const SizedBox(
                    height: 8,
                  ),
                  getProductRatingStat.when(
                    data: (data) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SondyaStarRating(
                            averageRating:
                                (data["data"]["averageRating"] as int)
                                    .toDouble(),
                          ),
                          Text(
                            "${data["data"]["totalReviews"]} Star Rating",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ],
                      );
                    },
                    loading: () => const CupertinoActivityIndicator(),
                    error: (error, stackTrace) => Text(error.toString()),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    data["data"]["name"],
                    style: GoogleFonts.playfairDisplay(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          children: [
                            const TextSpan(
                              text: 'Model:',
                              style: TextStyle(color: Color(0xFF5F6C72)),
                            ),
                            TextSpan(
                              text: data["data"]["model"],
                              style: const TextStyle(color: Color(0xFF000000)),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          children: [
                            const TextSpan(
                              text: 'Availability:',
                              style: TextStyle(color: Color(0xFF5F6C72)),
                            ),
                            TextSpan(
                              text: data["data"]["product_status"],
                              style: const TextStyle(color: Color(0xFFEDB842)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          children: [
                            const TextSpan(
                              text: 'Brand:',
                              style: TextStyle(color: Color(0xFF5F6C72)),
                            ),
                            TextSpan(
                              text: data["data"]["brand"],
                              style: const TextStyle(color: Color(0xFF000000)),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          children: [
                            const TextSpan(
                              text: 'Category:',
                              style: TextStyle(color: Color(0xFF5F6C72)),
                            ),
                            TextSpan(
                              text: data["data"]["sub_category"],
                              style: const TextStyle(color: Color(0xFFEDB842)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      PriceFormatWidget(
                        price:
                            (data["data"]["current_price"] as int).toDouble(),
                        fontSize: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      PriceFormatWidget(
                        price: (data["data"]["old_price"] as int).toDouble(),
                        oldPrice: true,
                        fontSize: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.all(
                            8.0), // Adjust padding as needed
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDB842), // Background color
                          borderRadius: BorderRadius.circular(
                              8.0), // Optional: Rounded corners
                        ),
                        child: Text(
                          "${data["data"]["discount_percentage"]} %off",
                          style: const TextStyle(
                            color: Colors.white, // Text color
                            fontSize: 16.0, // Font size
                            fontWeight: FontWeight.bold, // Font weight
                          ),
                        ),
                      )
                    ],
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text('Select Variant:', style: TextStyle(fontSize: 20)),
                  Wrap(
                    spacing: 5.0, // horizontal spacing between items
                    runSpacing: 5.0, // vertical spacing between lines
                    children: data["data"]["variants"].isNotEmpty
                        ? data["data"]["variants"]
                                ?.entries
                                ?.map<Widget>((entry) {
                              final key = entry.key;
                              final value = entry.value;
                              return SizedBox(
                                width: 200,
                                child: OutlinedButton(
                                  onPressed: () async {
                                    SondyaSelectWidget()
                                        .showBottomSheet<String>(
                                      options:
                                          value.whereType<String>().toList(),
                                      context: context,
                                      onItemSelected: (value) {},
                                    );
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        key.toString(),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      const Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                ),
                              );
                            })?.toList() ??
                            []
                        : [const Text("No variants")],
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.42,
                        height: 55,
                        child: TextField(
                          controller: quantityController,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          onChanged: (value) {
                            setState(() {
                              _quantity = value.isEmpty ? 0 : int.parse(value);
                              quantityController.text = _quantity.toString();
                            });

                            ref.read(updateCartProvider.notifier).updateCart({
                              "_id": widget.id,
                              "order_quantity": _quantity,
                              "name": data['data']['name']
                            });

                            // ignore: unused_result
                            ref.refresh(totalingProvider);
                            // ignore: unused_result
                            ref.refresh(getCartDataProvider);
                            // ignore: unused_result
                            ref.refresh(getTotalCartProvider);
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Quantity",
                            prefixIcon: Container(
                              decoration: BoxDecoration(
                                color: const Color(
                                    0xFFEDB842), // Set the background color here
                                borderRadius: BorderRadius.circular(
                                    8), // Optional: add border radius for rounded corners
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    // quantity cant be less than 0
                                    _quantity =
                                        _quantity <= 0 ? 0 : _quantity - 1;

                                    quantityController.text =
                                        _quantity.toString();
                                  });

                                  if (_quantity <= 0) {
                                    ref
                                        .read(removeFromCartProvider.notifier)
                                        .removeFromCart(widget.id);

                                    // ignore: unused_result
                                    ref.refresh(totalingProvider);
                                    // ignore: unused_result
                                    ref.refresh(getCartDataProvider);
                                    // ignore: unused_result
                                    ref.refresh(getTotalCartProvider);
                                  } else {
                                    ref
                                        .read(addToCartProvider.notifier)
                                        .addToCart({
                                      "_id": widget.id,
                                      "order_quantity": -1,
                                      "name": data['data']['name']
                                    });

                                    // ignore: unused_result
                                    ref.refresh(totalingProvider);
                                    // ignore: unused_result
                                    ref.refresh(getCartDataProvider);
                                    // ignore: unused_result
                                    ref.refresh(getTotalCartProvider);
                                  }
                                },
                                icon: const Icon(Icons.remove,
                                    color: Colors.white),
                              ),
                            ),
                            suffixIcon: Container(
                              decoration: BoxDecoration(
                                color: const Color(
                                    0xFFEDB842), // Set the background color here
                                borderRadius: BorderRadius.circular(
                                    8), // Optional: add border radius for rounded corners
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _quantity++;
                                    quantityController.text =
                                        _quantity.toString();
                                  });

                                  ref
                                      .read(addToCartProvider.notifier)
                                      .addToCart({
                                    "_id": widget.id,
                                    "order_quantity": 1,
                                    "name": data['data']['name']
                                  });

                                  // ignore: unused_result
                                  ref.refresh(totalingProvider);
                                  // ignore: unused_result
                                  ref.refresh(getCartDataProvider);
                                  // ignore: unused_result
                                  ref.refresh(getTotalCartProvider);
                                },
                                icon:
                                    const Icon(Icons.add, color: Colors.white),
                              ),
                            ),
                            // suffix: ,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 55,
                        child: ElevatedButton(
                            onPressed: () async {
                              await ref
                                  .read(addToCartProvider.notifier)
                                  .addToCart({
                                "_id": widget.id,
                                "order_quantity": 1,
                                "name": widget.name
                              });
                              // ignore: unused_result
                              ref.refresh(getCartDataProvider);
                              // ignore: unused_result
                              ref.refresh(getTotalCartProvider);
                            },
                            child: const Text("Add to cart")),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Contact Seller"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                            if (isFavorite) {
                              ref
                                  .read(addToWishlistProvider.notifier)
                                  .addToWishlist(
                                      widget.id, "product", widget.name);
                            } else {
                              ref
                                  .read(removeFromWishlistProvider.notifier)
                                  .removeFromWishlist(widget.id, "product");
                            }
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              size: 20,
                              color: const Color(0xFFEDB842),
                            ),
                            const SizedBox(width: 10),
                            const Text("Add to wishlist"),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Share product"),
                          IconButton(
                            onPressed: () {
                              copyToClipboard(
                                  "$appBaseAddress${widget.id}/${sondyaSlugify(widget.name)}");
                            },
                            icon: const Icon(Icons.copy),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.share),
                          ),
                        ],
                      )
                    ],
                  ),
                  ProductDetailsTab(
                    description: data["data"]["description"] ?? '',
                    owner: data["data"]["owner"] ?? {},
                    address: data["data"]["address"] ?? '',
                    country: data["data"]["country"] ?? '',
                    state: data["data"]["state"] ?? '',
                    city: data["data"]["city"] ?? '',
                    zipCode: data["data"]["zip_code"] ?? '',
                    subCategory: data["data"]["sub_category"] ?? '',
                    model: data["data"]["model"] ?? '',
                    brand: data["data"]["brand"] ?? '',
                    name: data["data"]["name"] ?? '',
                  ),
                  ReviewSection(
                    '',
                    category: data["data"]["category"] ?? 'product',
                    productId: data["data"]["_id"] ?? '',
                  ),
                ],
              );
            },
            loading: () => const CupertinoActivityIndicator(),
            error: (error, stackTrace) => Text(error.toString()),
          ),
        ),
      ),
    );
  }
}

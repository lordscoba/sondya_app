import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sondya_app/data/local/cart.dart';
import 'package:sondya_app/data/remote/home.dart';
import 'package:sondya_app/domain/providers/cart.provider.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';
import 'package:sondya_app/utils/slugify.dart';

class CartItem extends ConsumerStatefulWidget {
  final String? id;
  final int? quantity;
  final String? name;

  const CartItem({
    super.key,
    this.id,
    this.quantity,
    this.name,
  });

  @override
  ConsumerState<CartItem> createState() => _CartItemState();
}

class _CartItemState extends ConsumerState<CartItem> {
  int _quantity = 0;

  final TextStyle textStyleTax = const TextStyle(
    color: Colors.grey,
    fontSize: 13,
    fontWeight: FontWeight.w300,
  );

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity ?? 0;
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController quantityController =
        TextEditingController(text: _quantity.toString());

    final getProductDetails = ref.watch(getProductDetailsProvider(
        (id: widget.id!, name: sondyaSlugify(widget.name!))));
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      height: 190,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFEDB842)),
        ),
      ),
      child: getProductDetails.when(
        data: (data) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  GestureDetector(
                    onTap: () {
                      ref
                          .read(removeFromCartProvider.notifier)
                          .removeFromCart(widget.id!);
                      // ignore: unused_result
                      ref.refresh(totalingProvider);
                      // ignore: unused_result
                      ref.refresh(getCartDataProvider);
                      // ignore: unused_result
                      ref.refresh(getTotalCartProvider);
                    },
                    child: const Text(
                      "Remove",
                      style: TextStyle(
                          color: Color(0xFFEDB842),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
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
                  Row(
                    children: [
                      Text("Tax: \$1,", style: textStyleTax),
                      Text("Shipping: \$2,", style: textStyleTax),
                      Text("Discount: \$3", style: textStyleTax),
                    ],
                  ),
                  PriceFormatWidget(
                    price: data['data']['current_price'].toDouble(),
                    fontSize: 20,
                  ),
                  PriceFormatWidget(
                    price: data['data']['current_price'].toDouble(),
                    priceMultiple: widget.quantity!,
                    prefix: "Subtotal: ",
                    fontSize: 16,
                    fontFamily: GoogleFonts.openSans().fontFamily,
                    color: Colors.black87,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 150,
                      height: 40,
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
                                      .removeFromCart(widget.id!);

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
                              icon:
                                  const Icon(Icons.remove, color: Colors.white),
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

                                ref.read(addToCartProvider.notifier).addToCart({
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
                              icon: const Icon(Icons.add, color: Colors.white),
                            ),
                          ),
                          // suffix: ,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  )
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

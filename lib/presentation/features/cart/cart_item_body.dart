import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItem extends ConsumerStatefulWidget {
  final int? quantity;
  final String? name;
  final double? price;
  final String? imageString;

  const CartItem({
    super.key,
    this.quantity,
    this.name,
    this.price,
    this.imageString,
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
    _quantity = 0;
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController quantityController =
        TextEditingController(text: _quantity.toString());
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      height: 190,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFEDB842)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                  image: AssetImage("assets/shapes/circle_25.png"),
                  height: 100),
              Text(
                "Remove",
                style: TextStyle(
                    color: Color(0xFFEDB842),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
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
              Row(
                children: [
                  Text("Tax: \$1,", style: textStyleTax),
                  Text("Shipping: \$2,", style: textStyleTax),
                  Text("Discount: \$3", style: textStyleTax),
                ],
              ),
              Text(
                "\$ 4,000",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: const Color(0xFFEDB842),
                  fontFamily: GoogleFonts.openSans().fontFamily,
                ),
              ),
              Text(
                "Subtotal: \$ 4,000",
                style: TextStyle(
                    fontFamily: GoogleFonts.openSans().fontFamily,
                    fontSize: 16),
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
                              _quantity = _quantity <= 0 ? 0 : _quantity - 1;
                              quantityController.text = _quantity.toString();
                            });
                          },
                          icon: const Icon(Icons.remove, color: Colors.white),
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
                              quantityController.text = _quantity.toString();
                            });
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
      ),
    );
  }
}

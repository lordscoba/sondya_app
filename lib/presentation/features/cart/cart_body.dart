import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/presentation/features/cart/apply_discount_code.dart';
import 'package:sondya_app/presentation/features/cart/cart_item_body.dart';
import 'package:sondya_app/presentation/features/cart/estimated_shipping_tax.dart';

class CartBody extends ConsumerStatefulWidget {
  const CartBody({super.key});

  @override
  ConsumerState<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends ConsumerState<CartBody> {
  final TextStyle textStyleConCluding = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          // height: 1200,
          width: double.infinity,
          padding: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              const Text(
                "Cart",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(
                color: Color(0xFFEDB842),
              ),
              ListView(
                shrinkWrap: true,
                children: const [
                  CartItem(),
                  CartItem(),
                  CartItem(),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 160,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Continue"),
                    ),
                  ),
                  SizedBox(
                    width: 160,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Clear Cart"),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20.0),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDB842).withOpacity(.33),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    const Text(
                      "Summary",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const EstimatedShippingAndTaxBody(),
                    const ApplyDiscountCodeBody(),
                    SizedBox(
                      height: 280,
                      width: double.infinity,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          ListTile(
                            leadingAndTrailingTextStyle: textStyleConCluding,
                            leading: const Text("Sub Total"),
                            trailing: const Text("\$ 4,000"),
                          ),
                          ListTile(
                            leadingAndTrailingTextStyle: textStyleConCluding,
                            leading: const Text("Total Shipping Fees"),
                            trailing: const Text("\$ 21"),
                            subtitle: const Text(
                                "(Standard Rate - Price may vary depending on the item/destination. TECS Staff will contact you.)"),
                          ),
                          ListTile(
                            leadingAndTrailingTextStyle: textStyleConCluding,
                            leading: const Text("Total Tax"),
                            trailing: const Text("\$ 1"),
                          ),
                          ListTile(
                            leadingAndTrailingTextStyle: textStyleConCluding,
                            leading: const Text("Total Discount"),
                            trailing: const Text("\$ 3"),
                          ),
                          ListTile(
                            leadingAndTrailingTextStyle: textStyleConCluding,
                            leading: const Text("Order Total"),
                            trailing: const Text("\$ 4,000"),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: 400,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0156FF),
                        ),
                        onPressed: () {},
                        child: const Text("Checkout"),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

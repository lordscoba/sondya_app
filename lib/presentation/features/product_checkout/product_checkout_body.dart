import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/presentation/features/product_checkout/delivery_option_body.dart';
import 'package:sondya_app/presentation/features/product_checkout/payment_method_body.dart';
import 'package:sondya_app/presentation/features/product_checkout/product_item_body.dart';
import 'package:sondya_app/presentation/features/product_checkout/shipping_address_body.dart';

class ProductCheckoutBody extends ConsumerStatefulWidget {
  const ProductCheckoutBody({super.key});

  @override
  ConsumerState<ProductCheckoutBody> createState() =>
      _ProductCheckoutBodyState();
}

class _ProductCheckoutBodyState extends ConsumerState<ProductCheckoutBody> {
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
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                "Product Checkout",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  ProductCheckoutItem(),
                  ProductCheckoutItem(),
                  // ProductCheckoutItem(),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Discount Code",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Discount Code"),
                    Text("Apply"),
                  ],
                ),
              ),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    leadingAndTrailingTextStyle: textStyleConCluding,
                    leading: const Text("Sub Total"),
                    trailing: const Text("\$ 4,000"),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    leadingAndTrailingTextStyle: textStyleConCluding,
                    leading: const Text("Shipping Cost"),
                    trailing: const Text("\$ 4"),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    leadingAndTrailingTextStyle: textStyleConCluding,
                    leading: const Text("Discount"),
                    trailing: const Text("\$ 4"),
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    leadingAndTrailingTextStyle: textStyleConCluding,
                    leading: const Text("Total"),
                    trailing: const Text("\$ 4,000"),
                  )
                ],
              ),
              const CheckoutShippingAddressBody(),
              const CheckoutPaymentMethodBody(),
              const CheckoutDeliveryOptionBody(),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Pay \$188.00"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

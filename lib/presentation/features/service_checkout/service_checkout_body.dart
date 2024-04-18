import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/presentation/features/product_checkout/delivery_option_body.dart';
import 'package:sondya_app/presentation/features/product_checkout/payment_method_body.dart';
import 'package:sondya_app/presentation/features/product_checkout/shipping_address_body.dart';
import 'package:sondya_app/presentation/widgets/picture_slider.dart';

class ServiceCheckoutBody extends ConsumerStatefulWidget {
  const ServiceCheckoutBody({super.key});

  @override
  ConsumerState<ServiceCheckoutBody> createState() =>
      _ServiceCheckoutBodyState();
}

class _ServiceCheckoutBodyState extends ConsumerState<ServiceCheckoutBody> {
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
              const SondyaPictureSlider(
                pictureList: [
                  {
                    "url":
                        "https://res.cloudinary.com/df4c9rdyq/image/upload/v1701980854/sondya/gcxk3g0crkg3dh7suf0e.jpg",
                    "public_id": "sondya/gcxk3g0crkg3dh7suf0e",
                    "folder": "sondya",
                    "_id": "65722ab6fbbcca9851accff2"
                  }
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Text("Duration: 4 days, "),
                  Text("Revision: 1"),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Car Repair",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                  "Package includes Only Laptop-scenes Includes, Background Music,Logo, and 720HD Video"),
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

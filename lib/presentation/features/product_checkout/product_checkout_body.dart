import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sondya_app/data/local/cart.dart';
import 'package:sondya_app/domain/providers/checkout.provider.dart';
import 'package:sondya_app/presentation/features/product_checkout/delivery_option_body.dart';
import 'package:sondya_app/presentation/features/product_checkout/payment_method_body.dart';
import 'package:sondya_app/presentation/features/product_checkout/product_item_body.dart';
import 'package:sondya_app/presentation/features/product_checkout/shipping_address_body.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';

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
    final getCartList = ref.watch(getCartDataProvider);
    final getCartTotaling = ref.watch(totalingProvider);

    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(initializeFlutterwaveProvider);
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.canPop()
                  ? Row(
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
                    )
                  : const SizedBox(),
              const SizedBox(height: 10.0),
              const Text(
                "Product Checkout",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              getCartList.when(
                data: (data) {
                  // print(data);
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      // return const Text("hy");
                      return ProductCheckoutItem(
                        id: data[index].id,
                        quantity: data[index].orderQuantity,
                        name: data[index].name,
                      );
                    },
                  );
                },
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => const CircularProgressIndicator(),
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
              getCartTotaling.when(
                data: (dataP) {
                  // update payment request state
                  ref.watch(paymentRequestprovider.notifier).state.amount =
                      dataP.total!;

                  // update product order state
                  ref
                      .watch(productOrderDataprovider.notifier)
                      .state
                      .totalAmount = dataP.total!;

                  ref
                      .watch(productOrderDataprovider.notifier)
                      .state
                      .totalDiscount = dataP.totalDiscount!;
                  ref.watch(productOrderDataprovider.notifier).state.totalTax =
                      dataP.totalTax!;
                  ref
                      .watch(productOrderDataprovider.notifier)
                      .state
                      .totalShippingFee = dataP.totalShippingFee!;

                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        leadingAndTrailingTextStyle: textStyleConCluding,
                        leading: const Text("Sub Total"),
                        trailing: PriceFormatWidget(
                          price: dataP.subTotal!,
                          fontFamily: GoogleFonts.openSans().fontFamily,
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        leadingAndTrailingTextStyle: textStyleConCluding,
                        leading: const Text("Total Tax"),
                        trailing: PriceFormatWidget(
                          price: dataP.totalTax!,
                          fontFamily: GoogleFonts.openSans().fontFamily,
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        leadingAndTrailingTextStyle: textStyleConCluding,
                        leading: const Text("Shipping Cost"),
                        trailing: PriceFormatWidget(
                          price: dataP.totalShippingFee!,
                          fontFamily: GoogleFonts.openSans().fontFamily,
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        leadingAndTrailingTextStyle: textStyleConCluding,
                        leading: const Text("Discount"),
                        trailing: PriceFormatWidget(
                          price: dataP.totalDiscount!,
                          fontFamily: GoogleFonts.openSans().fontFamily,
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        leadingAndTrailingTextStyle: textStyleConCluding,
                        leading: const Text("Total"),
                        trailing: PriceFormatWidget(
                          price: dataP.total!,
                          fontFamily: GoogleFonts.openSans().fontFamily,
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      )
                    ],
                  );
                },
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => const CircularProgressIndicator(),
              ),
              const CheckoutShippingAddressBody(),
              const CheckoutPaymentMethodBody(),
              const CheckoutDeliveryOptionBody(),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.push('/product/checkout/confirmation');
                  },
                  child: checkState.isLoading
                      ? sondyaThreeBounceLoader(color: Colors.white)
                      : PriceFormatWidget(
                          price: ref.watch(paymentRequestprovider).amount,
                          fontFamily: GoogleFonts.openSans().fontFamily,
                          color: Colors.white,
                          fontSize: 14,
                          prefix: "Pay: ",
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

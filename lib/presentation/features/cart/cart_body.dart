import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sondya_app/data/local/cart.dart';
import 'package:sondya_app/domain/providers/cart.provider.dart';
import 'package:sondya_app/presentation/features/cart/apply_discount_code.dart';
import 'package:sondya_app/presentation/features/cart/cart_item_body.dart';
import 'package:sondya_app/presentation/features/cart/estimated_shipping_tax.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';

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
    final getCartList = ref.watch(getCartDataProvider);
    final getCartTotaling = ref.watch(totalingProvider);

    return SingleChildScrollView(
      child: Center(
        child: Container(
          // height: 1200,
          width: double.infinity,
          padding: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              context.canPop()
                  ? Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Navigator.pop(context);
                            context.pop();
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(height: 10.0),
              const Text(
                "Cart",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(
                color: Color(0xFFEDB842),
              ),
              getCartList.when(
                data: (data) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return CartItem(
                        id: data[index].id,
                        quantity: data[index].orderQuantity,
                        name: data[index].name,
                      );
                    },
                  );
                },
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => const CupertinoActivityIndicator(
                  radius: 50,
                ),
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
                      onPressed: () async {
                        ref
                            .read(removeAllCartProvider.notifier)
                            .removeAllCart();
                        // ignore: unused_result
                        ref.refresh(totalingProvider);
                        // ignore: unused_result
                        ref.refresh(getCartDataProvider);
                        // ignore: unused_result
                        ref.refresh(getTotalCartProvider);
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
                      child: getCartTotaling.when(
                        data: (dataP) {
                          return ListView(
                            shrinkWrap: true,
                            children: [
                              ListTile(
                                leadingAndTrailingTextStyle:
                                    textStyleConCluding,
                                leading: const Text("Sub Total"),
                                trailing: PriceFormatWidget(
                                  price: dataP.subTotal!,
                                  fontFamily: GoogleFonts.openSans().fontFamily,
                                  color: Colors.black87,
                                  fontSize: 14,
                                ),
                              ),
                              ListTile(
                                leadingAndTrailingTextStyle:
                                    textStyleConCluding,
                                leading: const Text("Total Shipping Fees"),
                                trailing: PriceFormatWidget(
                                  price: dataP.totalShippingFee!,
                                  fontFamily: GoogleFonts.openSans().fontFamily,
                                  color: Colors.black87,
                                  fontSize: 14,
                                ),
                                subtitle: const Text(
                                    "(Standard Rate - Price may vary depending on the item/destination. TECS Staff will contact you.)"),
                              ),
                              ListTile(
                                leadingAndTrailingTextStyle:
                                    textStyleConCluding,
                                leading: const Text("Total Tax"),
                                trailing: PriceFormatWidget(
                                  price: dataP.totalTax!,
                                  fontFamily: GoogleFonts.openSans().fontFamily,
                                  color: Colors.black87,
                                  fontSize: 14,
                                ),
                              ),
                              ListTile(
                                leadingAndTrailingTextStyle:
                                    textStyleConCluding,
                                leading: const Text("Total Discount"),
                                trailing: PriceFormatWidget(
                                  price: dataP.totalDiscount!,
                                  fontFamily: GoogleFonts.openSans().fontFamily,
                                  color: Colors.black87,
                                  fontSize: 14,
                                ),
                              ),
                              ListTile(
                                leadingAndTrailingTextStyle:
                                    textStyleConCluding,
                                leading: const Text("Order Total"),
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
                        loading: () => const Center(
                          child: CupertinoActivityIndicator(
                            radius: 50,
                          ),
                        ),
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
                        onPressed: () {
                          context.push('/product/checkout');
                          // check whether the person is logged in
                        },
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

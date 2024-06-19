import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sondya_app/data/remote/checkout.dart';
import 'package:sondya_app/domain/models/checkout.dart';
import 'package:sondya_app/domain/providers/checkout.provider.dart';

class ProductCheckoutStatusBody extends ConsumerStatefulWidget {
  const ProductCheckoutStatusBody({super.key});

  @override
  ConsumerState<ProductCheckoutStatusBody> createState() =>
      _ProductCheckoutStatusBodyState();
}

class _ProductCheckoutStatusBodyState
    extends ConsumerState<ProductCheckoutStatusBody> {
  late Map<String, dynamic> verifyData;
  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
    verifyData = ref.read(checkoutDataprovider);
  }

  @override
  Widget build(BuildContext context) {
    final getVerificationStatus =
        ref.watch(verifyCheckoutPaymentProvider(verifyData['tx_ref']));

    return SingleChildScrollView(
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: double.infinity,
          padding: const EdgeInsets.all(13.0),
          child: getVerificationStatus.when(
            data: (data) {
              if (data["data"]["data"]["status"] == "successful") {
                if (ref.watch(ispaymentDone) == true) {
                  final createProduct =
                      ref.watch(createProductOrderProvider(data));

                  return createProduct.when(
                    data: (data2) {
                      // delay for 3 seconds
                      Future.delayed(const Duration(seconds: 1), () {
                        // make productOrderDataprovider empty
                        ref.watch(productOrderDataprovider.notifier).state =
                            CreateProductOrderType();

                        ref.watch(ispaymentDone.notifier).state = false;

                        ref.read(checkoutDataprovider.notifier).state = {};
                      });
                      return const CheckoutSucessFFF();
                    },
                    loading: () => const Center(
                      child: CupertinoActivityIndicator(
                        radius: 50,
                      ),
                    ),
                    error: (error, stackTrace) => Text(error.toString()),
                  );
                } else {
                  return const CheckoutSucessFFF();
                }
              } else {
                return CheckoutFailureFFF(
                  message: data["data"]["message"],
                );
              }
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const CupertinoActivityIndicator(
              radius: 50,
            ),
          ),
        ),
      ),
    );
  }
}

class CheckoutSucessFFF extends ConsumerWidget {
  const CheckoutSucessFFF({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Image(image: AssetImage('assets/images/success_picture.png')),
        const SizedBox(height: 20),
        Text(
          "Thanks for your order",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.playfairDisplay().fontFamily),
        ),
        const SizedBox(height: 20),
        const Text(
          "We are preparing your order and will notify you as soon as it has shipped.",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF807D7E),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              context.push("/");
            },
            child: const Text("Continue Shopping")),
      ],
    );
  }
}

class CheckoutFailureFFF extends StatelessWidget {
  final String message;
  const CheckoutFailureFFF({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Image(image: AssetImage('assets/images/failure_picture.png')),
        const SizedBox(height: 20),
        Text(
          "Payment was unsucessful",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.playfairDisplay().fontFamily),
        ),
        const SizedBox(height: 20),
        Text(
          message,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF807D7E),
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          "Click on the link to try again",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF807D7E),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              context.push("/product/checkout");
            },
            child: const Text("Continue")),
      ],
    );
  }
}

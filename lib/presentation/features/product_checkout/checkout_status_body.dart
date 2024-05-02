import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sondya_app/data/remote/checkout.dart';
import 'package:sondya_app/domain/providers/checkout.provider.dart';

class ProductCheckoutStatusBody extends ConsumerWidget {
  const ProductCheckoutStatusBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getVerificationStatus = ref.watch(verifyCheckoutPaymentProvider(
        ref.watch(checkoutDataprovider.notifier).state['tx_ref']));
    return SingleChildScrollView(
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: double.infinity,
          padding: const EdgeInsets.all(13.0),
          child: getVerificationStatus.when(
            data: (data) {
              print(data);
              return const CheckoutSucessFFF();
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class CheckoutSucessFFF extends StatelessWidget {
  const CheckoutSucessFFF({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
  const CheckoutFailureFFF({
    super.key,
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
            child: const Text("Continue Shopping")),
      ],
    );
  }
}

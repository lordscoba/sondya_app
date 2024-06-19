import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/domain/providers/checkout.provider.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';

class ProductCheckoutConfirmationBody extends ConsumerWidget {
  const ProductCheckoutConfirmationBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(initializeFlutterwaveProvider);
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.3,
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(10),
            color: Colors.grey,
            dashPattern: const [8, 4], // Adjust dash and space lengths
            strokeWidth: 2,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Image(
                      image: AssetImage('assets/logos/sondya_logo_side.png'),
                      height: 40,
                      width: 180,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20),
                    ref.watch(ispaymentDone)!
                        ? const Text("Click here to verify payment")
                        : const Text("Click here to pay via flutterwave"),
                    const SizedBox(height: 20),
                    ref.watch(ispaymentDone)!
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                context.go('/product/checkout/status');
                              },
                              child: const Text("Verify Payment"),
                            ),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(
                                        initializeFlutterwaveProvider.notifier)
                                    .initPayment(
                                        ref.read(paymentRequestprovider),
                                        context);
                              },
                              child: checkState.isLoading
                                  ? sondyaThreeBounceLoader(color: Colors.white)
                                  : const Text("Continue to Flutterwave"),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

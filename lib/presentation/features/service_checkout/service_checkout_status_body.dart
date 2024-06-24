import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/checkout.dart';
import 'package:sondya_app/data/remote/user.order.dart';
import 'package:sondya_app/domain/providers/checkout.provider.dart';
import 'package:sondya_app/presentation/features/product_checkout/checkout_status_body.dart';
import 'package:sondya_app/utils/calc_delivery_time.dart';

class ServiceCheckoutStatusBody extends ConsumerStatefulWidget {
  final Map<String, dynamic> data;
  const ServiceCheckoutStatusBody({super.key, required this.data});

  @override
  ConsumerState<ServiceCheckoutStatusBody> createState() =>
      _ServiceCheckoutStatusBodyState();
}

class _ServiceCheckoutStatusBodyState
    extends ConsumerState<ServiceCheckoutStatusBody> {
  late Map<String, dynamic> verifyData;

  late Map<String, dynamic> updateData;
  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
    verifyData = ref.read(checkoutServiceDataprovider);

    // initialize updateData
    updateData = widget.data;
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
                if (ref.watch(ispaymentServiceDone) == true) {
                  updateData["payment_status"] = data["data"]["data"]["status"];
                  updateData["checkout_items"]["delivery_time"] =
                      calculateDeliveryTime(
                          durationUnit: updateData["checkout_items"]?["terms"]
                                  ?["durationUnit"] ??
                              "",
                          duration: updateData["checkout_items"]?["terms"]
                                  ?["duration"] ??
                              "");

                  final updateService =
                      ref.watch(updateUserServiceOrderProvider(updateData));

                  return updateService.when(
                    data: (data2) {
                      // delay for 3 seconds
                      Future.delayed(const Duration(seconds: 1), () {
                        ref.watch(ispaymentServiceDone.notifier).state = false;

                        ref.read(checkoutServiceDataprovider.notifier).state =
                            {};
                      });
                      return const CheckoutSucessFFF(
                        isService: true,
                      );
                    },
                    loading: () => const Center(
                      child: CupertinoActivityIndicator(
                        radius: 50,
                      ),
                    ),
                    error: (error, stackTrace) => Text(error.toString()),
                  );
                } else {
                  return const CheckoutSucessFFF(
                    isService: true,
                  );
                }
              } else {
                return CheckoutFailureFFF(
                  message: data["data"]["message"],
                  isService: true,
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

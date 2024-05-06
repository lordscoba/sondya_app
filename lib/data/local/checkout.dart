import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:sondya_app/data/app_constants.dart';
import 'package:sondya_app/data/hive_boxes.dart';
import 'package:sondya_app/data/storage_constants.dart';
import 'package:sondya_app/domain/hive_models/auth/auth.dart';
import 'package:sondya_app/domain/models/checkout.dart';
import 'package:sondya_app/domain/providers/checkout.provider.dart';
import 'package:uuid/uuid.dart';

final getCheckoutAuthProvider =
    FutureProvider.autoDispose<AuthInfo>((ref) async {
  try {
    // get boxForCart data list
    final AuthInfo obj = boxAuth.get(EnvironmentStorageConfig.authSession);

    final Owner user = Owner(
      id: obj.id,
      username: obj.username,
      email: obj.email,
      phoneNumber: obj.phoneNumber,
    );

    // update payment request state
    ref.watch(paymentRequestprovider.notifier).state.buyer = user;

    // update product order state
    ref.watch(productOrderDataprovider.notifier).state.buyer = user;

    return obj;
  } on Error catch (e) {
    return throw Exception("Failed to fetch map data error: ${e.toString()}");
  }
});

class InitializeFlutterwaveNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  final Ref ref;
  InitializeFlutterwaveNotifier(this.ref) : super(const AsyncValue.data({}));

  Future<void> initPayment(
      PaymentRequestType data, BuildContext context) async {
    try {
      // Set loading state
      state = const AsyncValue.loading();

      final txRef = "sondya-${const Uuid().v4()}";

      final Customer customer = Customer(
          name: data.buyer.username,
          phoneNumber: data.buyer.phoneNumber,
          email: data.buyer.email);

      final Flutterwave flutterwave = Flutterwave(
          context: context,
          publicKey: flutterPublicKey,
          currency: data.currency,
          redirectUrl: data.redirectUrl,
          txRef: txRef,
          amount: data.amount.toString(),
          customer: customer,
          paymentOptions: "ussd, card, barter, payattitude",
          customization: Customization(title: "My Payment"),
          isTestMode: true);

      final ChargeResponse response = await flutterwave.charge();

      ref.watch(checkoutDataprovider.notifier).state = response.toJson();

      ref.watch(ispaymentDone.notifier).state = true;

      state = AsyncValue.data(response.toJson());
    } on Error catch (e) {
      print(e.toString());
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}

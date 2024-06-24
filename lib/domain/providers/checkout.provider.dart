import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/local/checkout.dart';
import 'package:sondya_app/domain/models/checkout.dart';

// General (Both Product and Service)

final initializeFlutterwaveProvider = StateNotifierProvider.autoDispose<
    InitializeFlutterwaveNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return InitializeFlutterwaveNotifier(ref);
});

// for product only
final paymentRequestprovider = StateProvider<PaymentRequestType>(
  (ref) => PaymentRequestType(
    buyer: Owner(id: '', username: '', email: '', phoneNumber: ''),
    amount: 0.0,
    currency: 'USD',
    redirectUrl: "/product/checkout/status",
  ),
);

final checkoutDataprovider = StateProvider<Map<String, dynamic>>(
  (ref) => {},
  // (ref) => {
  //   "status": "successful",
  //   "success": true,
  //   "transaction_id": 5060256,
  //   "tx_ref": "sondya-4fc69a15-587f-44df-baf3-7791c983632f"
  // },
);

final productOrderDataprovider = StateProvider<CreateProductOrderType>(
  (ref) => CreateProductOrderType(
    redirectUrl: "/products/checkout/success",
    currency: "USD",
  ),
);

final ispaymentDone = StateProvider<bool>((ref) => false);

// for service only

final paymentServiceRequestprovider = StateProvider<PaymentRequestType>(
  (ref) => PaymentRequestType(
    buyer: Owner(id: '', username: '', email: '', phoneNumber: ''),
    amount: 0.0,
    currency: 'USD',
    redirectUrl: "/product/checkout/status",
  ),
);

final checkoutServiceDataprovider = StateProvider<Map<String, dynamic>>(
  (ref) => {},
  // (ref) => {
  //   "status": "successful",
  //   "success": true,
  //   "transaction_id": 5060256,
  //   "tx_ref": "sondya-4fc69a15-587f-44df-baf3-7791c983632f"
  // },
);
final ispaymentServiceDone = StateProvider<bool>((ref) => false);

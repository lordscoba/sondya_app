import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/user.order.dart';
import 'package:sondya_app/domain/models/checkout.dart';
import 'package:sondya_app/domain/providers/checkout.provider.dart';
import 'package:sondya_app/presentation/widgets/collapsible_widget.dart';
import 'package:sondya_app/presentation/widgets/picture_slider.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';

class ServiceCheckoutBody extends ConsumerStatefulWidget {
  final String sellerId;
  final String serviceId;
  const ServiceCheckoutBody(
      {super.key, required this.sellerId, required this.serviceId});

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

  late Map<String, dynamic> checkData;

  late PaymentRequestType payment;

  String paymentMethod = "card";

  @override
  void initState() {
    super.initState();

    checkData = {
      "seller_id": widget.sellerId,
      "service_id": widget.serviceId,
    };

    payment = PaymentRequestType(
      buyer: Owner(
        id: "",
        username: "",
        email: "",
        phoneNumber: "",
      ),
      amount: 0,
      currency: "USD",
      redirectUrl: "/success",
    );
  }

  @override
  Widget build(BuildContext context) {
    final getServiceDetails =
        ref.watch(checkUserServiceOrderProvider(checkData));

    // getServiceDetails.when(data: (data) {
    //   // print(data["order_exist"]);
    //   print(data["checkout_items"]["image"]);
    // }, error: (error, stackTrace) {
    //   print(error);
    // }, loading: () {
    //   return const SizedBox();
    // });
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(initializeFlutterwaveProvider);
    return SingleChildScrollView(
      child: Center(
        child: getServiceDetails.when(
          data: (data) {
            payment.amount =
                data["checkout_items"]["terms"]["amount"].toDouble();
            return Container(
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
                                context.pop();
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                          ],
                        )
                      : Container(),
                  SondyaPictureSlider(
                    pictureList: data["checkout_items"]["image"] != null &&
                            data["checkout_items"]["image"].isNotEmpty
                        ? data["checkout_items"]["image"]
                        : [
                            {
                              "url": "https://picsum.photos/500/300",
                              "public_id": "sondya/gcxk3g0crkg3dh7suf0e",
                              "folder": "sondya",
                              "_id": "65722ab6fbbcca9851accff2"
                            }
                          ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      // Text("Duration: 4 days, "),
                      Text(
                          "Duration: ${data["checkout_items"]["terms"]["duration"] ?? "No Duration"} ${data["checkout_items"]["terms"]["durationUnit"] ?? ""}, "),
                      const Text("Revision: 1"),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    data["checkout_items"]["name"] ?? "No Name",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    data["checkout_items"]["brief_description"] ??
                        "No Description",
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        leadingAndTrailingTextStyle: textStyleConCluding,
                        leading: const Text("Sub Total"),
                        trailing: Text(
                            "\$ ${data["checkout_items"]["terms"]["amount"].toString()}"),
                      ),
                      const Divider(),
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        leadingAndTrailingTextStyle: textStyleConCluding,
                        leading: const Text("Total"),
                        trailing: Text(
                            "\$ ${data["checkout_items"]["terms"]["amount"].toString()}"),
                      )
                    ],
                  ),
                  CheckoutSellerDetailsBody(
                    details: data["checkout_items"]["owner"],
                    city: data["checkout_items"]["city"],
                    state: data["checkout_items"]["state"],
                    country: data["checkout_items"]["country"],
                    phoneNumber: data["checkout_items"]["phone_number"],
                    address: data["checkout_items"]["location_description"],
                    phoneNumberBackup: data["checkout_items"]
                        ["phone_number_backup"],
                  ),
                  CheckoutPaymentMethodSerBody(
                    onChangedR: (value) {
                      setState(() {
                        paymentMethod = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  data["terms_agreed"]
                      ? SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (mounted) {
                                if (paymentMethod == "card") {
                                  // print(payment.toJson());
                                  ref
                                      .read(initializeFlutterwaveProvider
                                          .notifier)
                                      .initServicePayment(payment, context);
                                } else {
                                  print("Payment method is mobile wallet");
                                }
                              }
                            },
                            child: checkState.isLoading
                                ? sondyaThreeBounceLoader(color: Colors.white)
                                : Text(
                                    "Pay \$${data["checkout_items"]["terms"]["amount"].toDouble().toString()}"),
                          ),
                        )
                      : SizedBox(
                          height: 160,
                          width: double.infinity,
                          child: Column(
                            children: [
                              const SizedBox(
                                width: 400,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "Since you have not agreed to service terms, you cannot proceed to checkout. click on the button below to agree to service terms with the seller.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.orangeAccent,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // print(data["terms_agreed"]);
                                    // print(data["order_id"]);
                                    context.push(
                                        "/user/service/order/review/terms/${data["order_id"]}");
                                  },
                                  child: const Column(
                                    children: [
                                      Text("Agree to Service Terms"),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            );
          },
          loading: () => const CupertinoActivityIndicator(),
          error: (error, stackTrace) => Text(error.toString()),
        ),
      ),
    );
  }
}

class CheckoutPaymentMethodSerBody extends StatefulWidget {
  final void Function(String?)? onChangedR;
  const CheckoutPaymentMethodSerBody({super.key, this.onChangedR});

  @override
  State<CheckoutPaymentMethodSerBody> createState() =>
      _CheckoutPaymentMethodSerBodyState();
}

class _CheckoutPaymentMethodSerBodyState
    extends State<CheckoutPaymentMethodSerBody> {
  int _selectedValue = 0; // Initially selected value
  String selectedString = 'Card';

  void Function(int?)? _handleRadioValueChanged(value) {
    if (value == 0) {
      setState(() {
        _selectedValue = value!;
        selectedString = "Card";
        widget.onChangedR!(selectedString);
      });
    } else {
      setState(() {
        _selectedValue = value!;
        selectedString = "Mobile wallet";
        widget.onChangedR!(selectedString);
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return CollapsibleWidget(
      isVisible: true,
      title: "Payment Method",
      child: Column(
        children: [
          Row(
            children: [
              Radio(
                value: 0,
                groupValue: _selectedValue,
                onChanged: _handleRadioValueChanged,
              ),
              const Text("card"),
            ],
          ),
          Row(
            children: [
              Radio(
                value: 1,
                groupValue: _selectedValue,
                onChanged: _handleRadioValueChanged,
              ),
              const Text("Mobile wallet"),
            ],
          ),
        ],
      ),
    );
  }
}

class CheckoutSellerDetailsBody extends StatelessWidget {
  final Map<String, dynamic> details;
  final String city;
  final String state;
  final String country;
  final String phoneNumber;
  final String phoneNumberBackup;
  final String address;
  const CheckoutSellerDetailsBody(
      {super.key,
      required this.details,
      required this.city,
      required this.state,
      required this.country,
      required this.phoneNumber,
      required this.address,
      required this.phoneNumberBackup});

  @override
  Widget build(BuildContext context) {
    return CollapsibleWidget(
      startColumn: true,
      padding: 0,
      isVisible: true,
      title: "Seller Details Summary",
      child: Container(
        padding: const EdgeInsets.all(12.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black38,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "username: ${(details["username"] == null || details["username"].trim().isEmpty) ? details["email"] : details["username"]}"),
            Text("$address / $city, $state, $country."),
            Text("Phone Number: $phoneNumber or $phoneNumberBackup"),
            Text("Email: ${details["email"]}")
          ],
        ),
      ),
    );
  }
}

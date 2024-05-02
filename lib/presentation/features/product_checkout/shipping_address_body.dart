import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/local/checkout.dart';
import 'package:sondya_app/data/remote/checkout.dart';
import 'package:sondya_app/presentation/widgets/collapsible_widget.dart';

class CheckoutShippingAddressBody extends ConsumerStatefulWidget {
  const CheckoutShippingAddressBody({super.key});

  @override
  ConsumerState<CheckoutShippingAddressBody> createState() =>
      _CheckoutShippingAddressBodyState();
}

class _CheckoutShippingAddressBodyState
    extends ConsumerState<CheckoutShippingAddressBody> {
  bool _isChecked = false;

  late String name;
  late String email;

  late String mode;

  @override
  void initState() {
    super.initState();

    name = '';
    email = '';
    mode = 'local'; // local or profile
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    final getShipDataList = ref.watch(getShippingAddressProvider(mode));

    // final authData = ref.watch(storedAuthValueProvider);

    final authData = ref.watch(getCheckoutAuthProvider);

    authData.whenData(
      (data) {
        setState(() {
          name = data.username;
          email = data.email;
        });
      },
    );

    return CollapsibleWidget(
      padding: 0,
      isVisible: true,
      title: "Shipping Address Summary",
      child: getShipDataList.when(
        data: (dataW) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black38,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Column(children: [
                        Text("username: $name"),
                        Text(
                            "${dataW.address} / ${dataW.city}, ${dataW.state}, ${dataW.country}."),
                        Text("Phone Number: ${dataW.phoneNumber}"),
                        Text("Email: $email")
                      ]),
                    ),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                        onPressed: () {
                          context.push('/cart');
                        },
                        child: const Text("Edit"),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value!;
                        mode = _isChecked ? 'profile' : 'local';
                      });
                    },
                  ),
                  const Text("Billing address is same as shipping"),
                ],
              )
            ],
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}

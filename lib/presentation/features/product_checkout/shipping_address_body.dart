import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  @override
  Widget build(BuildContext context) {
    return CollapsibleWidget(
      padding: 0,
      isVisible: true,
      title: "Shipping Address Summary",
      child: Column(
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
                  child: const Column(children: [
                    Text("Adekunle Gilbert"),
                    Text(
                        "East Ikoyi Bazar, Word No. 04, Road No. 13/x, House no. 1320/C, Flat No. 5D, Ikeja - 1200, Lagos"),
                    Text("Phone Number: +234 1234 567 890 "),
                    Text("Email:kevin.gilbert@gmail.com")
                  ]),
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton(
                    onPressed: () {},
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
                  });
                },
              ),
              const Text("Billing address is same as shipping"),
            ],
          )
        ],
      ),
    );
  }
}

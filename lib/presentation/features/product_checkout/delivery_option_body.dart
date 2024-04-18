import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/presentation/widgets/collapsible_widget.dart';

class CheckoutDeliveryOptionBody extends ConsumerStatefulWidget {
  const CheckoutDeliveryOptionBody({super.key});

  @override
  ConsumerState<CheckoutDeliveryOptionBody> createState() =>
      _CheckoutDeliveryOptionBodyState();
}

class _CheckoutDeliveryOptionBodyState
    extends ConsumerState<CheckoutDeliveryOptionBody> {
  int _selectedValue = 0; // Initially selected value
  String _selectedString = 'Shipping';

  void Function(int?)? _handleRadioValueChanged(value) {
    if (_selectedValue == 0) {
      setState(() {
        _selectedValue = value!;
        _selectedString = "Shipping";
      });
    } else {
      setState(() {
        _selectedValue = value!;
        _selectedString = "Air Delivery";
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    print(_selectedString);
    return CollapsibleWidget(
      isVisible: true,
      title: "Delivery Option",
      child: Column(
        children: [
          Row(
            children: [
              Radio(
                value: 0,
                groupValue: _selectedValue,
                onChanged: _handleRadioValueChanged,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Shipping"),
                    Text(
                        " Free Shipping Estimated delivery: May 10 2023 - December 12 2024")
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: 1,
                groupValue: _selectedValue,
                onChanged: _handleRadioValueChanged,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Air Delivery"),
                    Text("GIG Estimated delivery: May 10 2023 - May 12 2023"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

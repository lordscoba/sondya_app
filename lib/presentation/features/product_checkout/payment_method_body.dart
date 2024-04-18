import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/presentation/widgets/collapsible_widget.dart';

class CheckoutPaymentMethodBody extends ConsumerStatefulWidget {
  const CheckoutPaymentMethodBody({super.key});

  @override
  ConsumerState<CheckoutPaymentMethodBody> createState() =>
      _CheckoutPaymentMethodBodyState();
}

class _CheckoutPaymentMethodBodyState
    extends ConsumerState<CheckoutPaymentMethodBody> {
  int _selectedValue = 0; // Initially selected value
  String _selectedString = 'Card';

  void Function(int?)? _handleRadioValueChanged(value) {
    if (_selectedValue == 0) {
      setState(() {
        _selectedValue = value!;
        _selectedString = "Card";
      });
    } else {
      setState(() {
        _selectedValue = value!;
        _selectedString = "Mobile wallet";
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    print(_selectedString);
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

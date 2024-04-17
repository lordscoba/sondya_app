import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/presentation/widgets/collapsible_widget.dart';
import 'package:sondya_app/utils/input_validations.dart';

class ApplyDiscountCodeBody extends ConsumerStatefulWidget {
  const ApplyDiscountCodeBody({super.key});

  @override
  ConsumerState<ApplyDiscountCodeBody> createState() =>
      _ApplyDiscountCodeBodyState();
}

class _ApplyDiscountCodeBodyState extends ConsumerState<ApplyDiscountCodeBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // user = LoginModel();
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    return CollapsibleWidget(
      title: "Apply Discount Code",
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text("Enter discount code"),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                hintText: " Enter your Zip Code",
                labelText: 'Phone Zip Code',
              ),
              validator: isInputEmail,
              onSaved: (value) {
                // user.email = value!;
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 400,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text("Apply Discount"),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

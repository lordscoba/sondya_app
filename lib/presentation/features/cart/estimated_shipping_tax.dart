import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/presentation/widgets/collapsible_widget.dart';
import 'package:sondya_app/utils/input_validations.dart';

class EstimatedShippingAndTaxBody extends ConsumerStatefulWidget {
  const EstimatedShippingAndTaxBody({super.key});

  @override
  ConsumerState<EstimatedShippingAndTaxBody> createState() =>
      _EstimatedShippingAndTaxBodyState();
}

class _EstimatedShippingAndTaxBodyState
    extends ConsumerState<EstimatedShippingAndTaxBody> {
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
      title: "Estimate Shipping and Tax",
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text("Enter your destination to get a shipping estimate."),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: " Enter your Country",
                  labelText: 'Country',
                ),
                validator: isInputEmail,
                onSaved: (value) {
                  // user.email = value!;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: " Enter your State/Province",
                  labelText: 'State/Province',
                ),
                validator: isInputEmail,
                onSaved: (value) {
                  // user.email = value!;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: " Enter your City/Town",
                  labelText: 'City/Town',
                ),
                validator: isInputEmail,
                onSaved: (value) {
                  // user.email = value!;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: " Enter your Address",
                  labelText: 'Address',
                ),
                validator: isInputEmail,
                onSaved: (value) {
                  // user.email = value!;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: " Enter your Phone Number",
                  labelText: 'Phone Number',
                ),
                validator: isInputEmail,
                onSaved: (value) {
                  // user.email = value!;
                },
              ),
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
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Save"),
                ),
              ),
              const SizedBox(height: 20),
            ],
          )),
    );
  }
}

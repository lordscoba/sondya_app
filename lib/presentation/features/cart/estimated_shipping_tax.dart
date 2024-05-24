import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/local/cart.dart';
import 'package:sondya_app/domain/hive_models/shipment_info/shipment.dart';
import 'package:sondya_app/domain/providers/cart.provider.dart';
import 'package:sondya_app/presentation/widgets/collapsible_widget.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
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
  late ShippingDestinationType ship;

  @override
  void initState() {
    super.initState();
    ship = ShippingDestinationType(
        id: '0',
        country: '',
        state: '',
        city: '',
        address: '',
        zipcode: '',
        phoneNumber: '');
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(updateShippingDestinationProvider);

    final getShipDataList = ref.watch(getShipmentDestinationdDataProvider);
    return CollapsibleWidget(
      title: "Estimate Shipping and Tax",
      child: getShipDataList.when(
        data: (dataW) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                checkState.when(
                  data: (data) {
                    return const SizedBox();
                    // return sondyaDisplaySuccessMessage(context, "Success");
                  },
                  loading: () => const SizedBox(),
                  error: (error, stackTrace) =>
                      sondyaDisplayErrorMessage(error.toString(), context),
                ),
                const SizedBox(height: 20),
                const Text(
                    "Enter your destination to get a shipping estimate."),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter your Country",
                    labelText: 'Country',
                  ),
                  initialValue: dataW.country,
                  validator: isInputEmpty,
                  onSaved: (value) {
                    ship.country = value!;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter your State/Province",
                    labelText: 'State/Province',
                  ),
                  initialValue: dataW.state,
                  validator: isInputEmpty,
                  onSaved: (value) {
                    ship.state = value!;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter your City/Town",
                    labelText: 'City/Town',
                  ),
                  initialValue: dataW.city,
                  validator: isInputEmpty,
                  onSaved: (value) {
                    ship.city = value!;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter your Address",
                    labelText: 'Address',
                  ),
                  initialValue: dataW.address,
                  validator: isInputEmpty,
                  onSaved: (value) {
                    ship.address = value!;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter your Phone Number",
                    labelText: 'Phone Number',
                  ),
                  initialValue: dataW.phoneNumber,
                  validator: isInputEmpty,
                  onSaved: (value) {
                    ship.phoneNumber = value!;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter your Zip Code",
                    labelText: 'Phone Zip Code',
                  ),
                  initialValue: dataW.zipcode,
                  validator: isInputEmpty,
                  onSaved: (value) {
                    ship.zipcode = value!;
                  },
                ),
                const SizedBox(height: 20),
                checkState.hasValue &&
                        !checkState.hasError &&
                        !checkState.isLoading
                    ? const Text("saved successfully")
                    : const SizedBox(),
                SizedBox(
                  height: 50,
                  width: 400,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();

                        // debugPrint(ship.toJson().toString());

                        await ref
                            .read(updateShippingDestinationProvider.notifier)
                            .updateDestination(ship.toJson());
                      } else {
                        AnimatedSnackBar.rectangle(
                          'Error',
                          "Please fill all the fields",
                          type: AnimatedSnackBarType.warning,
                          brightness: Brightness.light,
                        ).show(
                          context,
                        );
                      }
                    },
                    child: const Text("Save"),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const CupertinoActivityIndicator(
          radius: 50,
        ),
      ),
    );
  }
}

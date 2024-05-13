import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/utils/input_validations.dart';

class SellerOrderUpdateLocationBody extends ConsumerStatefulWidget {
  const SellerOrderUpdateLocationBody({super.key});

  @override
  ConsumerState<SellerOrderUpdateLocationBody> createState() =>
      _SellerOrderUpdateLocationBodyState();
}

class _SellerOrderUpdateLocationBodyState
    extends ConsumerState<SellerOrderUpdateLocationBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
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
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text("Country",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: " Enter Country",
                              // labelText: 'Country',
                            ),
                            initialValue: "Country",
                            validator: isInputEmpty,
                            onSaved: (value) {
                              // user.firstName = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text("State",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: " Enter State",
                              // labelText: 'State',
                            ),
                            initialValue: "State",
                            validator: isInputEmpty,
                            onSaved: (value) {
                              // user.firstName = value!;
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text("City",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: " Enter City",
                              // labelText: 'City',
                            ),
                            initialValue: "City",
                            validator: isInputEmpty,
                            onSaved: (value) {
                              // user.firstName = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text("Zip Code",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Enter Zip Code",
                              // labelText: 'Zip Code',
                            ),
                            initialValue: "Zip Code",
                            validator: isInputEmpty,
                            onSaved: (value) {
                              // user.firstName = value!;
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const Text("Order Status",
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter Order Status",
                    // labelText: 'Order Status',
                  ),
                  initialValue: "Order Status",
                  validator: isInputEmpty,
                  onSaved: (value) {
                    // user.firstName = value!;
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Update Location"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

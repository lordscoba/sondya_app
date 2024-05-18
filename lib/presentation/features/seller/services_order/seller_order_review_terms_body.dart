import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/utils/input_validations.dart';

class SellerOrderReviewTermsBody extends ConsumerStatefulWidget {
  final Map<String, dynamic> data;
  final String id;
  const SellerOrderReviewTermsBody(
      {super.key, required this.data, required this.id});

  @override
  ConsumerState<SellerOrderReviewTermsBody> createState() =>
      _SellerOrderReviewTermsBodyState();
}

class _SellerOrderReviewTermsBodyState
    extends ConsumerState<SellerOrderReviewTermsBody> {
  final _formKey = GlobalKey<FormState>();
  var _selectedTimeType = "hours";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 10),
                  const Text("Edit Terms", style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  const Text("Amount", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: " Enter Amount",
                      // labelText: 'Address',
                    ),
                    initialValue: "200.0",
                    validator: isInputEmpty,
                    onSaved: (value) {
                      // user.firstName = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                      "These terms were set and accepted by the seller. Click \"Accept\" to proceed or \"Reject\" to Edit the terms"),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const Text("Duration",
                                style: TextStyle(color: Colors.grey)),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: " Enter Duration",
                                  // labelText: 'Brand',
                                ),
                                initialValue: "0",
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  // user.firstName = value!;
                                },
                              ),
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
                            const Text("Duration",
                                style: TextStyle(color: Colors.grey)),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: BorderSide.none),
                                onPressed: () async {
                                  List<String> sortByList = [
                                    "hours",
                                    "days",
                                    "weeks",
                                    "months",
                                  ];
                                  SondyaSelectWidget().showBottomSheet<String>(
                                    options: sortByList,
                                    context: context,
                                    onItemSelected: (value) {
                                      setState(() {
                                        _selectedTimeType = value;
                                      });
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _selectedTimeType,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    const Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                      "Note: You and Seller must click the “Accept Button” for the agreement to hold. Both parties will be notified on this"),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                            }
                          },
                          child: const Text("Reject"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                            }
                          },
                          child: const Text("Accept"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/user.order.dart';
import 'package:sondya_app/domain/providers/user.order.provider.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
import 'package:sondya_app/utils/input_validations.dart';

class UserOrderReviewTermsBody extends ConsumerStatefulWidget {
  final String id;
  const UserOrderReviewTermsBody({super.key, required this.id});

  @override
  ConsumerState<UserOrderReviewTermsBody> createState() =>
      _UserOrderReviewTermsBodyState();
}

class _UserOrderReviewTermsBodyState
    extends ConsumerState<UserOrderReviewTermsBody> {
  final _formKey = GlobalKey<FormState>();
  var _selectedTimeType = "Select Time Type";

  bool acceptClicked = false;
  bool rejectClicked = false;

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(updateUserServiceOrderTermsProvider);

    final sellerOrderData =
        ref.watch(getUserServiceOrdersDetailsDetailsProvider(widget.id));
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: sellerOrderData.when(
              data: (data) {
                if (data["checkout_items"]["terms"]["durationUnit"]
                        .isNotEmpty &&
                    _selectedTimeType == "Select Time Type") {
                  _selectedTimeType =
                      data["checkout_items"]["terms"]["durationUnit"];
                  // product.productStatus = _selectedTimeType;
                }
                return Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      checkState.when(
                        data: (data) {
                          if (data["data"] != null && data["data"].isNotEmpty) {
                            acceptClicked = false;
                            rejectClicked = false;
                          }
                          return sondyaDisplaySuccessMessage(
                              context, data["message"]);
                        },
                        loading: () => const SizedBox(),
                        error: (error, stackTrace) {
                          return sondyaDisplayErrorMessage(
                              error.toString(), context);
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text("Edit Terms", style: TextStyle(fontSize: 20)),
                      const SizedBox(height: 10),
                      const Text("Amount",
                          style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 5),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: " Enter Amount",
                        ),
                        initialValue: data["checkout_items"]["terms"]["amount"]
                            .toString(),
                        validator: isInputEmpty,
                        onSaved: (value) {
                          data["checkout_items"]["terms"]["amount"] =
                              double.parse(value!);
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
                                    ),
                                    initialValue: data["checkout_items"]
                                            ["terms"]["duration"]
                                        .toString(),
                                    validator: isInputEmpty,
                                    onSaved: (value) {
                                      data["checkout_items"]["terms"]
                                          ["duration"] = int.parse(value!);
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
                                      SondyaSelectWidget()
                                          .showBottomSheet<String>(
                                        options: sortByList,
                                        context: context,
                                        onItemSelected: (value) {
                                          setState(() {
                                            _selectedTimeType = value;
                                          });
                                          data["checkout_items"]["terms"]
                                              ["durationUnit"] = value;
                                        },
                                      );
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                      data["checkout_items"]["terms"]["acceptedBySeller"] &&
                              data["checkout_items"]["terms"]["acceptedByBuyer"]
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    onPressed: () {
                                      if (mounted) {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();

                                          setState(() {
                                            rejectClicked = true;
                                          });
                                          data["checkout_items"]["terms"]
                                              ["acceptedByBuyer"] = false;
                                          data["checkout_items"]["terms"]
                                              ["rejectedByBuyer"] = true;

                                          ref
                                              .read(
                                                  updateUserServiceOrderTermsProvider
                                                      .notifier)
                                              .updateOrder(
                                                  data["checkout_items"]
                                                      ["terms"],
                                                  data["order_id"]);

                                          // ignore: unused_result
                                          ref.refresh(
                                              getUserServiceOrdersDetailsDetailsProvider(
                                                  widget.id));
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
                                      }
                                    },
                                    child: checkState.isLoading && rejectClicked
                                        ? sondyaThreeBounceLoader(
                                            color: Colors.white)
                                        : const Text("Reject"),
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (mounted) {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          setState(() {
                                            acceptClicked = true;
                                          });
                                          data["checkout_items"]["terms"]
                                              ["acceptedByBuyer"] = true;
                                          data["checkout_items"]["terms"]
                                              ["rejectedByBuyer"] = false;

                                          ref
                                              .read(
                                                  updateUserServiceOrderTermsProvider
                                                      .notifier)
                                              .updateOrder(
                                                  data["checkout_items"]
                                                      ["terms"],
                                                  data["order_id"]);

                                          // ignore: unused_result
                                          ref.refresh(
                                              getUserServiceOrdersDetailsDetailsProvider(
                                                  widget.id));
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
                                      }
                                    },
                                    child: checkState.isLoading && acceptClicked
                                        ? sondyaThreeBounceLoader(
                                            color: Colors.white)
                                        : const Text("Accept"),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(
                              width: double.infinity,
                              child: Text(
                                "You and seller have accepted the terms and amount to be paid.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )),
                    ],
                  ),
                );
              },
              error: (error, stackTrace) {
                return Text(error.toString());
              },
              loading: () {
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}

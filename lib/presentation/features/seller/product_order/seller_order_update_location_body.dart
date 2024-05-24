import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/seller.order.dart';
import 'package:sondya_app/domain/models/seller/order.dart';
import 'package:sondya_app/domain/providers/seller.orders.provider.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
import 'package:sondya_app/utils/input_validations.dart';

class SellerOrderUpdateLocationBody extends ConsumerStatefulWidget {
  final String id;
  const SellerOrderUpdateLocationBody({super.key, required this.id});

  @override
  ConsumerState<SellerOrderUpdateLocationBody> createState() =>
      _SellerOrderUpdateLocationBodyState();
}

class _SellerOrderUpdateLocationBodyState
    extends ConsumerState<SellerOrderUpdateLocationBody> {
  final _formKey = GlobalKey<FormState>();
  var _selectedStatus = "";

  late UpdateSellerLocationType order;

  @override
  void initState() {
    super.initState();
    order = UpdateSellerLocationType();
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(updateSellerProductOrderProvider);

    final sellerOrderData =
        ref.watch(getSellerProductOrdersDetailsProvider(widget.id));
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: sellerOrderData.when(
            data: (data) {
              // print(data["order_location"]);
              return Form(
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
                    checkState.when(
                      data: (data) {
                        return sondyaDisplaySuccessMessage(
                            context, data["message"]);
                      },
                      loading: () => const SizedBox(),
                      error: (error, stackTrace) {
                        return sondyaDisplayErrorMessage(
                            error.toString(), context);
                      },
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
                                ),
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  order.country = value;
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
                                ),
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  order.state = value;
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
                                ),
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  order.city = value;
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
                                decoration: const InputDecoration(),
                                validator: isInputEmpty,
                                onSaved: (value) {
                                  order.zipCode = value;
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
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () async {
                          List<String> sortByList = [
                            "Order Placed",
                            "Processing",
                            "Packed",
                            "Shipping",
                            "Delivered",
                            "Cancelled",
                          ];
                          SondyaSelectWidget().showBottomSheet<String>(
                            options: sortByList,
                            context: context,
                            onItemSelected: (value) {
                              setState(() {
                                _selectedStatus = value;
                              });
                              order.orderStatus = value;
                            },
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _selectedStatus,
                              style: const TextStyle(fontSize: 12),
                            ),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              _selectedStatus.isNotEmpty) {
                            _formKey.currentState!.save();

                            data["order_location"].add(order.toJson());

                            ref
                                .read(updateSellerProductOrderProvider.notifier)
                                .updateOrder(data);

                            // ignore: unused_result
                            ref.refresh(getSellerProductOrdersDetailsProvider(
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
                        },
                        child: checkState.isLoading
                            ? sondyaThreeBounceLoader(color: Colors.white)
                            : const Text("Update Location"),
                      ),
                    ),
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
    );
  }
}

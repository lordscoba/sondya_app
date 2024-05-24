import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/seller.order.dart';
import 'package:sondya_app/domain/providers/seller.orders.provider.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';

class SellerOrderUpdateStatusBody extends ConsumerStatefulWidget {
  final String id;
  const SellerOrderUpdateStatusBody({super.key, required this.id});

  @override
  ConsumerState<SellerOrderUpdateStatusBody> createState() =>
      _SellerOrderUpdateStatusBodyState();
}

class _SellerOrderUpdateStatusBodyState
    extends ConsumerState<SellerOrderUpdateStatusBody> {
  final _formKey = GlobalKey<FormState>();
  var _selectedStatus = "Order Placed";

  // late Map<String, dynamic> order;

  @override
  void initState() {
    super.initState();
    // order = {"order_status": _selectedStatus};
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
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                  // order = {"order_status": value};
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
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            data["order_status"] = _selectedStatus;

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
                            : const Text("Update Status"),
                      ),
                    )
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

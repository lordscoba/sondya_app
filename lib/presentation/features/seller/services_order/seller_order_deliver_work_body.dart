import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/seller.order.dart';
import 'package:sondya_app/domain/providers/seller.orders.provider.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';

class SellerOrderDeliverWorkBody extends ConsumerStatefulWidget {
  final String id;
  const SellerOrderDeliverWorkBody({super.key, required this.id});

  @override
  ConsumerState<SellerOrderDeliverWorkBody> createState() =>
      _SellerOrderDeliverWorkBodyState();
}

class _SellerOrderDeliverWorkBodyState
    extends ConsumerState<SellerOrderDeliverWorkBody> {
  final _formKey = GlobalKey<FormState>();
  var _selectedStatus = "Select Status";
  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(updateSellerServiceOrderProvider);

    final sellerOrderData =
        ref.watch(getSellerServiceOrdersDetailsProvider(widget.id));
    return SingleChildScrollView(
      child: Center(
        child: sellerOrderData.when(
          data: (data) {
            if (data["order_status"].isNotEmpty &&
                _selectedStatus == "Select Status") {
              _selectedStatus = data["order_status"];
            }
            return Form(
              key: _formKey,
              child: Column(
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
                  const Text("Change Status"),
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
                              "order placed",
                              "IN PROGRESS",
                              "delivered"
                            ];
                            SondyaSelectWidget().showBottomSheet<String>(
                              options: sortByList,
                              context: context,
                              onItemSelected: (value) {
                                setState(() {
                                  _selectedStatus = value;
                                });
                                data["order_status"] = value;
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
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        if (mounted) {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            data["order_status"] = _selectedStatus;

                            ref
                                .read(updateSellerServiceOrderProvider.notifier)
                                .updateOrder(
                                  data,
                                  widget.id,
                                );

                            // ignore: unused_result
                            ref.refresh(getSellerServiceOrdersDetailsProvider(
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
                      child: checkState.isLoading
                          ? sondyaThreeBounceLoader(color: Colors.white)
                          : const Text("Save changes"),
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
    );
  }
}

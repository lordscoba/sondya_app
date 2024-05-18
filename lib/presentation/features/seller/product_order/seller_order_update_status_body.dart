import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';

class SellerOrderUpdateStatusBody extends ConsumerStatefulWidget {
  final Map<String, dynamic> data;
  final String id;
  const SellerOrderUpdateStatusBody(
      {super.key, required this.data, required this.id});

  @override
  ConsumerState<SellerOrderUpdateStatusBody> createState() =>
      _SellerOrderUpdateStatusBodyState();
}

class _SellerOrderUpdateStatusBodyState
    extends ConsumerState<SellerOrderUpdateStatusBody> {
  final _formKey = GlobalKey<FormState>();
  var _selectedStatus = "Order Placed";

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
                        context.pop();
                      }
                    },
                    child: const Text("Update Status"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

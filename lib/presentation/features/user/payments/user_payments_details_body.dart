import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/payments.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';
import 'package:sondya_app/utils/dateTime_to_string.dart';

class UserPaymentsDetailsBody extends ConsumerWidget {
  final String id;
  const UserPaymentsDetailsBody({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getSellerPaymentsDetails =
        ref.watch(getUserPaymentsDetailsProvider(id));

    // getSellerPaymentsDetails.whenData(
    //   (value) {
    //     print(value);
    //   },
    // );
    return SingleChildScrollView(
      child: Center(
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
            const SizedBox(
              height: 8,
            ),
            const Text(
              "Order Payments Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            getSellerPaymentsDetails.when(
              data: (data) {
                print(data);
                return Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder.all(
                    color: const Color(0xFFE0E7E9),
                    width: 0.5,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  children: [
                    TableRow(
                      children: [
                        Container(
                          height: 50,
                          color: const Color(0xFFE0E7E9),
                          padding: const EdgeInsets.all(5.0),
                          child: const Text("Title"),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text("Value"),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Container(
                          height: 50,
                          color: const Color(0xFFE0E7E9),
                          padding: const EdgeInsets.all(5.0),
                          child: const Text("Payment ID"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(data["payment_id"] ?? "N/A"),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Container(
                          height: 50,
                          color: const Color(0xFFE0E7E9),
                          padding: const EdgeInsets.all(5.0),
                          child: const Text("Paid by"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                              "${data["buyer"]["username"] ?? "N/A"}, ${data["buyer"]["email"] ?? "N/A"}"),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Container(
                          height: 50,
                          color: const Color(0xFFE0E7E9),
                          padding: const EdgeInsets.all(5.0),
                          child: const Text("Currency"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(data["currency"] ?? "N/A"),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Container(
                          height: 50,
                          color: const Color(0xFFE0E7E9),
                          padding: const EdgeInsets.all(5.0),
                          child: const Text("items(quantity)"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                              "${data["checkout_items"][0]["name"] ?? "N/A"}(${data["checkout_items"][0]["order_quantity"].toString()})..."),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Container(
                          height: 50,
                          color: const Color(0xFFE0E7E9),
                          padding: const EdgeInsets.all(5.0),
                          child: const Text("Payment method"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(data["payment_method"] ?? "N/A"),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Container(
                          height: 50,
                          color: const Color(0xFFE0E7E9),
                          padding: const EdgeInsets.all(5.0),
                          child: const Text("Status"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(data["payment_status"] ?? "N/A"),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Container(
                          height: 50,
                          color: const Color(0xFFE0E7E9),
                          padding: const EdgeInsets.all(5.0),
                          child: const Text("Date"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                              sondyaFormattedDate(data["createdAt"] ?? "")),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Container(
                          height: 50,
                          color: const Color(0xFFE0E7E9),
                          padding: const EdgeInsets.all(5.0),
                          child: const Text("Amount"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: PriceFormatWidget(
                              price: data["total_amount"].toDouble() ?? 0.0),
                        ),
                      ],
                    ),
                  ],
                );
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const Center(
                child: CupertinoActivityIndicator(
                  radius: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

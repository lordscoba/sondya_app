import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/seller.withdrawal.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';
import 'package:sondya_app/utils/dateTime_to_string.dart';

class SellerWithdrawalDetailsBody extends ConsumerWidget {
  final String id;
  const SellerWithdrawalDetailsBody({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getSellerWithdrawalDetails =
        ref.watch(getSellerwithdrawalDetailsProvider(id));

    // getSellerWithdrawalDetails.whenData(
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
              "Withdrawal Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            getSellerWithdrawalDetails.when(
              data: (data) {
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
                          child: const Text("Withdrawal ID"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(data["_id"] ?? ""),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Container(
                          height: 50,
                          color: const Color(0xFFE0E7E9),
                          padding: const EdgeInsets.all(5.0),
                          child: const Text("Withdrawn by"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                              "${data["user"]["email"] ?? ""}, ${data["user"]["username"] ?? ""}"),
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
                          child: Text(data["currency"] ?? ""),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Container(
                          height: 50,
                          color: const Color(0xFFE0E7E9),
                          padding: const EdgeInsets.all(5.0),
                          child: const Text("Withdrawal method"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(data["withdrawal_mode"] ?? ""),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Container(
                          height: 50,
                          color: const Color(0xFFE0E7E9),
                          padding: const EdgeInsets.all(5.0),
                          child: const Text("Withdrawal to"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                data["withdrawal_mode"] == "bank"
                                    ? Column(
                                        children: [
                                          Text(
                                              "${data["withdrawal_account"]["account_name"].toString()}, ${data["withdrawal_account"]["bank_name"].toString()}"),
                                          Text(data["withdrawal_account"]
                                                  ["account_number"]
                                              .toString()),
                                        ],
                                      )
                                    : data["withdrawal_mode"] == "payoneer"
                                        ? Column(
                                            children: [
                                              Text(data["withdrawal_account"]
                                                      ["email"]
                                                  .toString()),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Text(data["withdrawal_account"]
                                                      ["email"]
                                                  .toString()),
                                            ],
                                          ),
                              ]),
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
                          child: Text(data["withdrawal_status"] ?? ""),
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
                              price:
                                  data["withdrawal_amount"].toDouble() ?? 0.0),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/seller.account.dart';
import 'package:sondya_app/data/remote/seller.withdrawal.dart';
import 'package:sondya_app/presentation/widgets/price_formatter.dart';
import 'package:sondya_app/utils/dateTime_to_string.dart';

class SellerWithdrawalsBody extends ConsumerWidget {
  const SellerWithdrawalsBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getSellerWithdrawalsStats =
        ref.watch(getSellerwithdrawalStatusProvider);
    final getSellerWithdrawalsGetBalance =
        ref.watch(getSellerwithdrawalgetBalanceProvider);
    final getSellerWithdrawals = ref.watch(getSellerWithdrawalsProvider);
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
              const SizedBox(height: 10.0),
              const Text(
                "Withdrawal",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 5.0),
                          Text(
                            "Add Account",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.send),
                          SizedBox(width: 5.0),
                          Text(
                            "Withdraw",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10.0),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  Container(
                    width: 160,
                    height: 160,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Theme.of(context).colorScheme.background,
                      // add shadow
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: getSellerWithdrawalsGetBalance.when(
                      data: (data) {
                        // print(data);
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Total Funds"),
                            const SizedBox(height: 10.0),
                            PriceFormatWidget(
                              price: data["balance"].toDouble() ?? 0.0,
                            )
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
                  ),
                  Container(
                    width: 160,
                    height: 160,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Theme.of(context).colorScheme.background,
                      // add shadow
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: getSellerWithdrawalsStats.when(
                      data: (data) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Pending Withdrawal",
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10.0),
                            PriceFormatWidget(
                              price: data["pending"].toDouble() ?? 0.0,
                            )
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
                  ),
                  Container(
                    width: 160,
                    height: 160,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Theme.of(context).colorScheme.background,
                      // add shadow
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: getSellerWithdrawalsStats.when(
                      data: (data) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Completed"),
                            const SizedBox(height: 10.0),
                            PriceFormatWidget(
                              price: data["completed"].toDouble() ?? 0.0,
                            )
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
                  )
                ],
              ),
              const SizedBox(height: 10.0),
              const Text(
                "Withdrawal History",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              getSellerWithdrawals.when(
                data: (data) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'S/N',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Order date',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Sellers Name',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Account Details',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Amount',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Withdrawal Mode',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Status',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Action',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                      rows: data.isNotEmpty
                          ? data.asMap().entries.map<DataRow>((entry) {
                              int index = entry.key;
                              Map<String, dynamic> data = entry.value;
                              // print(data);
                              return DataRow(cells: <DataCell>[
                                DataCell(Text('${index + 1}')),
                                DataCell(Text(
                                    sondyaFormattedDate(data["createdAt"]))),
                                DataCell(Text(data["user"]["email"] ?? "")),
                                DataCell(
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        data["withdrawal_mode"] == "bank"
                                            ? Column(
                                                children: [
                                                  Text(
                                                      "${data["withdrawal_account"]["account_name"].toString()}, ${data["withdrawal_account"]["bank_name"].toString()}"),
                                                  Text(
                                                      data["withdrawal_account"]
                                                              ["account_number"]
                                                          .toString()),
                                                ],
                                              )
                                            : data["withdrawal_mode"] ==
                                                    "payoneer"
                                                ? Column(
                                                    children: [
                                                      Text(
                                                          data["withdrawal_account"]
                                                                  ["email"]
                                                              .toString()),
                                                    ],
                                                  )
                                                : Column(
                                                    children: [
                                                      Text(
                                                          data["withdrawal_account"]
                                                                  ["email"]
                                                              .toString()),
                                                    ],
                                                  ),
                                      ]),
                                ),
                                DataCell(PriceFormatWidget(
                                  price: data["withdrawal_amount"].toDouble() ??
                                      0.0,
                                )),
                                DataCell(Text(data["withdrawal_mode"] ?? "")),
                                DataCell(Text(data["withdrawal_status"] ?? "")),
                                DataCell(
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          context.push(
                                              "/seller/withdrawal/details/${data["_id"]}");
                                        },
                                        icon: const Icon(Icons.visibility),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          ref.read(
                                              getSellerwithdrawalDeleteProvider(
                                                  data["_id"]));

                                          // ignore: unused_result
                                          ref.refresh(
                                              getSellerWithdrawalsProvider);
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                ),
                              ]);
                            }).toList()
                          : <DataRow>[],
                    ),
                  );
                },
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => const Center(
                  child: CupertinoActivityIndicator(
                    radius: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

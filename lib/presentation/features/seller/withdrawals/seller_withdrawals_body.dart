import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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
                      onPressed: () {
                        context.push('/seller/add/account');
                      },
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
                      onPressed: () {
                        context.push('/seller/withdraw');
                      },
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
                              fontFamily: GoogleFonts.openSans().fontFamily,
                              fontSize: 18.0,
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
                              fontFamily: GoogleFonts.openSans().fontFamily,
                              fontSize: 18.0,
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
                              fontFamily: GoogleFonts.openSans().fontFamily,
                              fontSize: 18.0,
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
              const SizedBox(height: 20.0),
              const Text("Withdrawal Accounts",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10.0),
              getSellerWithdrawalsGetBalance.when(
                data: (data) {
                  return SizedBox(
                    height: 200,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Row(
                          children: data["bank_account"].isNotEmpty
                              ? data["bank_account"].map<Widget>((e) {
                                  return Row(
                                    children: [
                                      BankAccountDetails(data: e),
                                      const SizedBox(width: 10),
                                    ],
                                  );
                                }).toList()
                              : [],
                        ),
                        const SizedBox(width: 10),
                        Row(
                          children: data["paypal_account"].isNotEmpty
                              ? data["paypal_account"].map<Widget>((e) {
                                  return Row(
                                    children: [
                                      PaypalAccountDetails(data: e),
                                      const SizedBox(width: 10),
                                    ],
                                  );
                                }).toList()
                              : <Widget>[],
                        ),
                        const SizedBox(width: 10),
                        Row(
                          children: data["payoneer_account"].isNotEmpty
                              ? data["payoneer_account"].map<Widget>((e) {
                                  return Row(
                                    children: [
                                      PayoneerAccountDetails(data: e),
                                      const SizedBox(width: 10),
                                    ],
                                  );
                                }).toList()
                              : <Widget>[],
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  );
                },
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => const Center(
                  child: CupertinoActivityIndicator(
                    radius: 5,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
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

class BankAccountDetails extends ConsumerWidget {
  final Map<String, dynamic> data;
  const BankAccountDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 150,
      height: 150,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(data["bank_name"]),
          Text(data["account_name"]),
          Text(data["account_number"]),
          TextButton(
              onPressed: () {
                ref.read(deleteBankAccountProvider(data["account_id"]));
                // ignore: unused_result
                ref.refresh(getSellerwithdrawalgetBalanceProvider);
              },
              child: const Text("Delete",
                  style: TextStyle(color: Colors.redAccent))),
        ],
      ),
    );
  }
}

class PayoneerAccountDetails extends ConsumerWidget {
  final Map<String, dynamic> data;
  const PayoneerAccountDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 150,
      height: 150,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text("Payoneer Account"),
          Text(data["email"] ?? ""),
          TextButton(
              onPressed: () {
                ref.read(deletePayoneerAccountProvider(data["payoneer_id"]));
                // ignore: unused_result
                ref.refresh(getSellerwithdrawalgetBalanceProvider);
              },
              child: const Text("Delete",
                  style: TextStyle(color: Colors.redAccent)))
        ],
      ),
    );
  }
}

class PaypalAccountDetails extends ConsumerWidget {
  final Map<String, dynamic> data;
  const PaypalAccountDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 150,
      height: 150,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text("Paypal Account"),
          Text(data["email"] ?? ""),
          TextButton(
              onPressed: () {
                ref.read(deletePaypalAccountProvider(data["paypal_id"]));
                // ignore: unused_result
                ref.refresh(getSellerwithdrawalgetBalanceProvider);
              },
              child: const Text("Delete",
                  style: TextStyle(color: Colors.redAccent)))
        ],
      ),
    );
  }
}

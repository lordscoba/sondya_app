import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/seller.account.dart';
import 'package:sondya_app/data/remote/seller.withdrawal.dart';
import 'package:sondya_app/domain/models/seller/withdrawal.dart';
import 'package:sondya_app/domain/providers/withdrawal.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
import 'package:sondya_app/utils/input_validations.dart';

class SellerWithdrawBody extends ConsumerStatefulWidget {
  const SellerWithdrawBody({super.key});

  @override
  ConsumerState<SellerWithdrawBody> createState() => _SellerWithdrawBodyState();
}

class _SellerWithdrawBodyState extends ConsumerState<SellerWithdrawBody> {
  final _formKey = GlobalKey<FormState>();
  String _selectedMode = "bank";

  String _selectedRadioValue = "";

  late WithdrawalRequestModel withdrawData;

  @override
  void initState() {
    super.initState();
    withdrawData = WithdrawalRequestModel();
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    final getSellerWithdrawalsGetBalance =
        ref.watch(getSellerwithdrawalgetBalanceProvider);

    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(withdrawalRequestProvider);
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
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
                checkState.when(
                  data: (data) {
                    return sondyaDisplaySuccessMessage(
                        context, data["message"]);
                  },
                  loading: () => const SizedBox(),
                  error: (error, stackTrace) {
                    return sondyaDisplayErrorMessage(error.toString(), context);
                  },
                ),
                const SizedBox(height: 10.0),
                const Text(
                    "Money gotten from your buisness can be paid heres."),
                const SizedBox(height: 10.0),
                const Text("Enter Amount",
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                TextFormField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  decoration: const InputDecoration(
                    hintText: "Enter Amount",
                  ),
                  validator: isInputEmpty,
                  onSaved: (value) {
                    if (value != "") {
                      withdrawData.withdrawalAmount = double.parse(value!);
                    } else {
                      withdrawData.withdrawalAmount = 0.0;
                    }
                  },
                ),
                const SizedBox(height: 10),
                const Text("Input Payment Method",
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () async {
                      List<String> sortByList = [
                        "bank",
                        "paypal",
                        "payoneer",
                      ];
                      SondyaSelectWidget().showBottomSheet<String>(
                        options: sortByList,
                        context: context,
                        onItemSelected: (value) {
                          setState(() {
                            _selectedMode = value;
                            // print(value);
                          });
                          withdrawData.withdrawalMode = value;
                        },
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _selectedMode,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Select from existing accounts",
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  child: getSellerWithdrawalsGetBalance.when(
                    data: (data) {
                      print(data["bank_account"]);
                      return Column(children: [
                        if (_selectedMode == "bank")
                          ...data["bank_account"]
                              .asMap()
                              .entries
                              .map<Widget>((entry) {
                            int index = entry.key;
                            Map<String, dynamic> option = entry.value;

                            return RadioListTile<String>(
                              title: Column(
                                children: [
                                  Text(option["account_name"]),
                                  Text(
                                      "${option["account_number"]} ${option["bank_name"]}"),
                                ],
                              ),
                              value: "bank$index",
                              groupValue: _selectedRadioValue,
                              onChanged: (value) {
                                setState(() {
                                  _selectedRadioValue = value!;
                                  option.remove("_id");
                                  withdrawData.withdrawalAccount = option;
                                });
                              },
                            );
                          }).toList(),
                        if (_selectedMode == "paypal")
                          ...data["paypal_account"]
                              .asMap()
                              .entries
                              .map<Widget>((entry) {
                            int index = entry.key;
                            Map<String, dynamic> option = entry.value;
                            return RadioListTile<String>(
                              title: Text(option["email"]),
                              value: "paypal$index",
                              groupValue: _selectedRadioValue,
                              onChanged: (value) {
                                setState(() {
                                  _selectedRadioValue = value!;
                                  option.remove("_id");
                                  withdrawData.withdrawalAccount = option;
                                });
                              },
                            );
                          }).toList(),
                        if (_selectedMode == "payoneer")
                          ...data["payoneer_account"]
                              .asMap()
                              .entries
                              .map<Widget>((entry) {
                            int index = entry.key;
                            Map<String, dynamic> option = entry.value;
                            return RadioListTile<String>(
                              title: Text(option["email"]),
                              value: "payoneer$index",
                              groupValue: _selectedRadioValue,
                              onChanged: (value) {
                                setState(() {
                                  _selectedRadioValue = value!;
                                  option.remove("_id");
                                  withdrawData.withdrawalAccount = option;
                                });
                              },
                            );
                          }).toList(),
                        if (data["payoneer_account"].isEmpty &&
                            data["bank_account"].isEmpty &&
                            data["paypal_account"].isEmpty)
                          const Text(
                            "No accounts found, add account at withdrawal page",
                          ),
                      ]);
                    },
                    error: (error, stackTrace) => Text(error.toString()),
                    loading: () => const Center(
                      child: CupertinoActivityIndicator(
                        radius: 50,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          _selectedMode != "") {
                        _formKey.currentState!.save();

                        if (_selectedRadioValue != "") {
                          withdrawData.currency = "USD";
                          withdrawData.withdrawalMode = _selectedMode;
                          ref
                              .read(withdrawalRequestProvider.notifier)
                              .withdraw(withdrawData.toJson())
                              .then((value) {
                            // ignore: unused_result
                            ref.refresh(getSellerWithdrawalsProvider);

                            context.go("/seller/withdrawals");
                          });
                        } else {
                          AnimatedSnackBar.rectangle(
                            'Error',
                            "Please select withdrawal account from existing accounts",
                            type: AnimatedSnackBarType.warning,
                            brightness: Brightness.light,
                          ).show(
                            context,
                          );
                        }
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
                        : const Text("Withdraw"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

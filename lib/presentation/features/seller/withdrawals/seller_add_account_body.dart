import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/remote/seller.account.dart';
import 'package:sondya_app/domain/providers/account.provider.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';

class SellerAddAccountBody extends ConsumerStatefulWidget {
  const SellerAddAccountBody({super.key});

  @override
  ConsumerState<SellerAddAccountBody> createState() =>
      _SellerAddAccountBodyState();
}

class _SellerAddAccountBodyState extends ConsumerState<SellerAddAccountBody> {
  final _formKey = GlobalKey<FormState>();
  String _selectedMode = "bank";

  String _paypalEmail = "";
  String _payoneerEmail = "";
  String _bankName = "";
  String _accountName = "";
  String _accountNumber = "";
  String _routingNumber = "";
  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState1 =
        ref.watch(addBankAccountProvider);
    final AsyncValue<Map<String, dynamic>> checkState2 =
        ref.watch(addPaypalAccountProvider);
    final AsyncValue<Map<String, dynamic>> checkState3 =
        ref.watch(addPayoneerAccountProvider);
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
                checkState1.when(
                  data: (data) {
                    return sondyaDisplaySuccessMessage(
                        context, data["message"]);
                  },
                  loading: () => const SizedBox(),
                  error: (error, stackTrace) {
                    return sondyaDisplayErrorMessage(error.toString(), context);
                  },
                ),
                checkState2.when(
                  data: (data) {
                    return sondyaDisplaySuccessMessage(
                        context, data["message"]);
                  },
                  loading: () => const SizedBox(),
                  error: (error, stackTrace) {
                    return sondyaDisplayErrorMessage(error.toString(), context);
                  },
                ),
                checkState3.when(
                  data: (data) {
                    return sondyaDisplaySuccessMessage(
                        context, data["message"]);
                  },
                  loading: () => const SizedBox(),
                  error: (error, stackTrace) {
                    return sondyaDisplayErrorMessage(error.toString(), context);
                  },
                ),
                const SizedBox(height: 20.0),
                const Text(
                    "Money gotten from your buisness can be paid heres."),
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
                _selectedMode == "bank"
                    ? SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Input Your Bank Name",
                                style: TextStyle(color: Colors.grey)),
                            const SizedBox(height: 5),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: "Bank Name",
                              ),
                              onSaved: (value) {
                                _bankName = value!;
                              },
                            ),
                            const SizedBox(height: 10),
                            const Text("Input Your Account Number",
                                style: TextStyle(color: Colors.grey)),
                            const SizedBox(height: 5),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: " Account Number",
                              ),
                              onSaved: (value) {
                                _accountNumber = value!;
                              },
                            ),
                            const SizedBox(height: 10),
                            const Text("Input Your Account Name",
                                style: TextStyle(color: Colors.grey)),
                            const SizedBox(height: 5),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: " Account Name",
                              ),
                              onSaved: (value) {
                                _accountName = value!;
                              },
                            ),
                            const SizedBox(height: 10),
                            const Text("Input Your Rounting Number",
                                style: TextStyle(color: Colors.grey)),
                            const SizedBox(height: 5),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: " Rounting Number",
                              ),
                              onSaved: (value) {
                                _routingNumber = value!;
                              },
                            ),
                          ],
                        ),
                      )
                    : Container(),
                _selectedMode == "paypal"
                    ? SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const Text("Input Paypal recepient Email",
                                style: TextStyle(color: Colors.grey)),
                            const SizedBox(height: 5),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: "paypal email",
                              ),
                              onSaved: (value) {
                                _paypalEmail = value!;
                              },
                            ),
                          ],
                        ),
                      )
                    : Container(),
                _selectedMode == "payoneer"
                    ? SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const Text("Input payoneer recepient Email",
                                style: TextStyle(color: Colors.grey)),
                            const SizedBox(height: 5),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: "payoneer email",
                              ),
                              onSaved: (value) {
                                _payoneerEmail = value!;
                              },
                            ),
                          ],
                        ),
                      )
                    : Container(),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (_selectedMode == "bank") {
                          if (_bankName != "" &&
                              _accountNumber != "" &&
                              _accountName != "" &&
                              _routingNumber != "") {
                            Map<String, dynamic> data = {
                              "bank_name": _bankName,
                              "account_number": _accountNumber,
                              "account_name": _accountName,
                              "routing_number": _routingNumber
                            };
                            // print(data);
                            ref
                                .read(addBankAccountProvider.notifier)
                                .addBankAccount(data)
                                .then((value) {
                              context.go("/seller/withdrawals");
                              // ignore: unused_result
                              ref.refresh(
                                  getSellerwithdrawalgetBalanceProvider);
                            });
                            // context.go("/seller/withdrawals");
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
                        } else if (_selectedMode == "paypal") {
                          if (_paypalEmail != "") {
                            Map<String, dynamic> data = {"email": _paypalEmail};

                            ref
                                .read(addPaypalAccountProvider.notifier)
                                .addPaypalAccount(data)
                                .then((value) {
                              context.go("/seller/withdrawals");
                              // ignore: unused_result
                              ref.refresh(
                                  getSellerwithdrawalgetBalanceProvider);
                            });
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
                        } else if (_selectedMode == "payoneer") {
                          if (_payoneerEmail != "") {
                            Map<String, dynamic> data = {
                              "email": _payoneerEmail
                            };
                            // print(data);
                            ref
                                .read(addPayoneerAccountProvider.notifier)
                                .addPayoneerAccount(data)
                                .then((value) {
                              context.go("/seller/withdrawals");
                              // ignore: unused_result
                              ref.refresh(
                                  getSellerwithdrawalgetBalanceProvider);
                            });

                            // context.go("/seller/withdrawals");
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
                      }
                    },
                    // child: const Text("Add Account")),
                    child: checkState1.isLoading ||
                            checkState2.isLoading ||
                            checkState3.isLoading
                        ? sondyaThreeBounceLoader(color: Colors.white)
                        : const Text("Save Changes"),
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

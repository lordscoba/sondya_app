import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/utils/input_validations.dart';

class SellerAddAccountBody extends ConsumerStatefulWidget {
  const SellerAddAccountBody({super.key});

  @override
  ConsumerState<SellerAddAccountBody> createState() =>
      _SellerAddAccountBodyState();
}

class _SellerAddAccountBodyState extends ConsumerState<SellerAddAccountBody> {
  final _formKey = GlobalKey<FormState>();
  String _selectedMode = "bank";
  @override
  Widget build(BuildContext context) {
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
                            print(value);
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
                                // labelText: 'Product Name',
                              ),
                              initialValue: "Bank Name",
                              validator: isInputEmpty,
                              onSaved: (value) {
                                // user.firstName = value!;
                              },
                            ),
                            const SizedBox(height: 10),
                            const Text("Input Your Account Number",
                                style: TextStyle(color: Colors.grey)),
                            const SizedBox(height: 5),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: " Account Number",
                                // labelText: 'Product Name',
                              ),
                              initialValue: "Account Number",
                              validator: isInputEmpty,
                              onSaved: (value) {
                                // user.firstName = value!;
                              },
                            ),
                            const SizedBox(height: 10),
                            const Text("Input Your Account Name",
                                style: TextStyle(color: Colors.grey)),
                            const SizedBox(height: 5),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: " Account Name",
                                // labelText: 'Product Name',
                              ),
                              initialValue: "Account Name",
                              validator: isInputEmpty,
                              onSaved: (value) {
                                // user.firstName = value!;
                              },
                            ),
                            const SizedBox(height: 10),
                            const Text("Input Your Rounting Number",
                                style: TextStyle(color: Colors.grey)),
                            const SizedBox(height: 5),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: " Rounting Number",
                                // labelText: 'Product Name',
                              ),
                              initialValue: "Rounting Number",
                              validator: isInputEmpty,
                              onSaved: (value) {
                                // user.firstName = value!;
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
                                // labelText: 'Product Name',
                              ),
                              // initialValue: "paypal email",
                              validator: isInputEmpty,
                              onSaved: (value) {
                                // user.firstName = value!;
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
                                  // hintText: "payoneer email",
                                  // labelText: 'Product Name',
                                  ),
                              initialValue: "payoneer email",
                              validator: isInputEmpty,
                              onSaved: (value) {
                                // user.firstName = value!;
                              },
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

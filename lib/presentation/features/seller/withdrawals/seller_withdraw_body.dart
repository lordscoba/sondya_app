import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/widgets/select_widget.dart';
import 'package:sondya_app/utils/input_validations.dart';

class SellerWithdrawBody extends ConsumerStatefulWidget {
  const SellerWithdrawBody({super.key});

  @override
  ConsumerState<SellerWithdrawBody> createState() => _SellerWithdrawBodyState();
}

class _SellerWithdrawBodyState extends ConsumerState<SellerWithdrawBody> {
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
                const SizedBox(height: 10.0),
                const Text(
                    "Money gotten from your buisness can be paid heres."),
                const SizedBox(height: 10.0),
                const Text("Enter Amount",
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Enter Amount",
                    // labelText: 'Product Name',
                  ),
                  initialValue: "300.4",
                  validator: isInputEmpty,
                  onSaved: (value) {
                    // user.firstName = value!;
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
                const SizedBox(height: 10),
                const Text("Select from existing accounts",
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
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Withdraw"),
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

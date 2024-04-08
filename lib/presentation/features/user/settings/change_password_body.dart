import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/utils/input_validations.dart';

class ChangePasswordBody extends ConsumerStatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  ConsumerState<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends ConsumerState<ChangePasswordBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      extendBody: true,
      body: SingleChildScrollView(
          child: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 100.0),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter your current password",
                    labelText: 'Current Password',
                  ),
                  validator: isInputEmpty,
                  onSaved: (value) {
                    // user.email = value!;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter your New password",
                    labelText: 'New Password',
                  ),
                  validator: isInputEmpty,
                  onSaved: (value) {
                    // user.email = value!;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter your Confirm password",
                    labelText: 'Confirm New Password',
                  ),
                  validator: isInputEmpty,
                  onSaved: (value) {
                    // user.email = value!;
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                    }
                  },
                  child: const Text("Save Changes"),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}

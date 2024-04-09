import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/utils/input_validations.dart';

class KycCodeVerificationBody extends ConsumerStatefulWidget {
  const KycCodeVerificationBody({super.key});

  @override
  ConsumerState<KycCodeVerificationBody> createState() =>
      _KycCodeVerificationBodyState();
}

class _KycCodeVerificationBodyState
    extends ConsumerState<KycCodeVerificationBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          // height: 1200,
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "KYC Code Verification",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "Input the 4-digt code sent to your email for verification.",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 30.0),
                const Text("Verification Code"),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter your Code",
                    labelText: 'Code',
                  ),
                  validator: isInputEmpty,
                  onSaved: (value) {
                    // user.email = value!;
                  },
                ),
                const SizedBox(height: 5.0),
                const Text(
                  "A 4-digit code will be sent to your email which you will use for verification",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                    },
                    child: const Text("Save Changes"),
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                    "Check your spam account in your email, if you didn’t receive the email in your inbox.")
              ],
              // Your scrollable content here
            ),
          ),
        ),
      ),
    );
  }
}

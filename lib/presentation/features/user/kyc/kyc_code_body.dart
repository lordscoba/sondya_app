import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/domain/models/user/kyc.dart';
import 'package:sondya_app/domain/providers/kyc.provider.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
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
  late KycCodeModel user;

  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
    user = KycCodeModel();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(kycUserProvider);
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
                checkState.when(
                  data: (data) {
                    if (data.isNotEmpty) {
                      ref.invalidate(kycUserProvider);
                      // WidgetsBinding.instance.addPostFrameCallback(
                      //     (_) => context.push('/settings'));
                    }
                    return sondyaDisplaySuccessMessage(
                        context, data["message"]);
                  },
                  loading: () => const SizedBox(),
                  error: (error, stackTrace) {
                    ref.invalidate(kycUserProvider);

                    debugPrint(error.toString());
                    return sondyaDisplayErrorMessage(error.toString(), context);
                  },
                ),
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
                    user.code = value!;
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        await ref.read(kycUserProvider.notifier).kycVerifyCode(
                              user.toJson(),
                            );
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
                    // child: const Text("Save Changes"),
                    child: checkState.isLoading
                        ? sondyaThreeBounceLoader(color: Colors.white)
                        : const Text("Save Changes"),
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

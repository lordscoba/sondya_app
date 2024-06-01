import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/data/local/storedValue.dart';
import 'package:sondya_app/domain/models/user/kyc.dart';
import 'package:sondya_app/domain/providers/kyc.provider.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
import 'package:sondya_app/utils/input_validations.dart';

class KycEmailVerificationBody extends ConsumerStatefulWidget {
  const KycEmailVerificationBody({super.key});

  @override
  ConsumerState<KycEmailVerificationBody> createState() =>
      _KycEmailVerificationBodyState();
}

class _KycEmailVerificationBodyState
    extends ConsumerState<KycEmailVerificationBody> {
  final _formKey = GlobalKey<FormState>();
  late KycEmailModel user;

  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
    user = KycEmailModel();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(kycEmailProvider);
    final storedAuthValue = ref.watch(storedAuthValueProvider);
    return SingleChildScrollView(
      child: Center(
        child: Container(
          // height: 1200,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: _formKey,
            child: storedAuthValue.when(
              data: (data) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    checkState.when(
                      data: (data) {
                        if (data.isNotEmpty) {
                          WidgetsBinding.instance.addPostFrameCallback(
                              (_) => context.push('kyc/code/verify'));

                          // Optionally, refresh the kycEmailProvider
                          // ignore: unused_result
                          ref.refresh(kycEmailProvider);
                        }

                        return sondyaDisplaySuccessMessage(
                            context, data["message"]);
                      },
                      loading: () => const SizedBox(),
                      error: (error, stackTrace) {
                        // Optionally, refresh the kycEmailProvider
                        // ignore: unused_result
                        ref.refresh(kycEmailProvider);
                        return sondyaDisplayErrorMessage(
                            error.toString(), context);
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
                      "KYC Password Verification",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      "Enter the email address associated with the Sonya account you are logged into",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 30.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: " Enter your Email",
                        labelText: 'Email',
                      ),
                      readOnly: true,
                      initialValue: data.email,
                      validator: isInputEmail,
                      onSaved: (value) {
                        user.email = value!;
                      },
                    ),
                    const SizedBox(height: 5.0),
                    const Text(
                      "A 4-digit code will be sent to your email which you will use for verification",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            if (data.emailVerified == "false" ||
                                data.emailVerified == "") {
                              // Invalidate the kycEmailProvider to clear existing data
                              ref.invalidate(kycEmailProvider);

                              await ref
                                  .read(kycEmailProvider.notifier)
                                  .kycVerifyEmail(
                                    user.toJson(),
                                  );
                            } else {
                              AnimatedSnackBar.rectangle(
                                'Warning',
                                "Email already verified",
                                type: AnimatedSnackBarType.success,
                                brightness: Brightness.light,
                              ).show(
                                context,
                              );
                              context.push("/kyc/personal/information");
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
                            : const Text("Save Changes"),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                        "Check your spam account in your email, if you didn’t receive the email in your inbox.")
                  ],
                  // Your scrollable content here
                );
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const Center(
                child: CupertinoActivityIndicator(
                  radius: 50,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

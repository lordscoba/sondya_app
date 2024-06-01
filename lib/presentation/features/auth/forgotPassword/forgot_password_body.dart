import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/domain/models/auth/auth.dart';
import 'package:sondya_app/domain/providers/auth.provider.dart';
import 'package:sondya_app/presentation/widgets/circle_images.dart';
import 'package:sondya_app/presentation/widgets/success_error_message.dart';
import 'package:sondya_app/presentation/widgets/threebounce_loader.dart';
import 'package:sondya_app/utils/input_validations.dart';

class ForgotPasswordBody extends ConsumerStatefulWidget {
  const ForgotPasswordBody({super.key});

  @override
  ConsumerState<ForgotPasswordBody> createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends ConsumerState<ForgotPasswordBody> {
  late ForgotPasswordModel user;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    user = ForgotPasswordModel();
    // Initialize the variable in initState
  }

  @override
  void dispose() {
    // Cancel any ongoing asynchronous operations and clean up resources here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(forgotPasswordUserProvider);
    return SingleChildScrollView(
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const CircleImage(),
                checkState.when(
                  data: (data) {
                    if (data.isNotEmpty) {
                      // ref.invalidate(authUserProvider);
                      WidgetsBinding.instance.addPostFrameCallback((_) =>
                          context.push('/verificationCode/${user.email}'));
                    }
                    return sondyaDisplaySuccessMessage(
                        context, data["message"]);
                  },
                  loading: () => const SizedBox(),
                  error: (error, stackTrace) {
                    // ref.invalidate(authUserProvider);
                    return sondyaDisplayErrorMessage(error.toString(), context);
                  },
                ),
                const Text(
                  "Forget Password",
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  "Enter the email address or mobile phone number associated with your Sondya account.",
                  textAlign: TextAlign.center,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: " Enter your email",
                    labelText: 'Email',
                  ),
                  validator: isInputEmail,
                  onSaved: (value) {
                    user.email = value!;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    // context.push('/verificationCode');
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();

                      await ref
                          .read(forgotPasswordUserProvider.notifier)
                          .forgotPassword(
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
                  child: checkState.isLoading
                      ? sondyaThreeBounceLoader(color: Colors.white)
                      : const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Send Code"),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Text("Already have account?"),
                          TextButton(
                            onPressed: () {
                              context.push('/login');
                            },
                            child: const Text(
                              "Sign in",
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Don’t have account?"),
                          TextButton(
                            onPressed: () {
                              context.push('/register');
                            },
                            child: const Text(
                              "Sign Up",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const Text(
                    "You may contact Customer Service for help restoring access to your account."),
                const Divider(),
                const AuthFooterImages(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

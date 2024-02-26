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

class ResetPasswordBody extends ConsumerStatefulWidget {
  final String email;
  const ResetPasswordBody({required this.email, super.key});

  @override
  ConsumerState<ResetPasswordBody> createState() => _ResetPasswordBodyState();
}

class _ResetPasswordBodyState extends ConsumerState<ResetPasswordBody> {
  late ResetPasswordModel user;
  final _formKey = GlobalKey<FormState>();

  bool _obscureText1 = true;
  bool _obscureText2 = true;

  @override
  void initState() {
    super.initState();
    user = ResetPasswordModel();
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
        ref.watch(authUserProvider);
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          height: 650,
          width: 380,
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
                        ref.invalidate(authUserProvider);
                        WidgetsBinding.instance.addPostFrameCallback(
                            (_) => context.push('/login'));
                      }
                      return sondyaDisplaySuccessMessage(
                          context, data["message"]);
                    },
                    loading: () => const SizedBox(),
                    error: (error, stackTrace) {
                      ref.invalidate(authUserProvider);
                      return sondyaDisplayErrorMessage(
                          error.toString(), context);
                    }),
                const Text(
                  "Reset Password",
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  "Duis sagittis molestie tellus, at eleifend sapien pellque quis. Fusce lorem nunc, fringilla sit amet nunc.",
                  textAlign: TextAlign.center,
                ),
                TextFormField(
                  obscureText: _obscureText1,
                  decoration: InputDecoration(
                    hintText: "6+ characters",
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText1
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscureText1 = !_obscureText1;
                        });
                      },
                    ),
                  ),
                  validator: isInputEmpty,
                  onSaved: (value) {
                    user.password = value!;
                  },
                ),
                TextFormField(
                  obscureText: _obscureText2,
                  decoration: InputDecoration(
                    hintText: "6+ characters",
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText2
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscureText2 = !_obscureText2;
                        });
                      },
                    ),
                  ),
                  validator: isInputEmpty,
                  onSaved: (value) {
                    user.confirmPassword = value!;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    // context.push('/login');
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();

                      await ref.read(authUserProvider.notifier).resetPassword(
                            user.toJson(),
                            widget.email,
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
                            Text("Reset Password"),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                ),
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

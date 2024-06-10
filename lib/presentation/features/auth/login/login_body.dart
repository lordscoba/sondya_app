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

class LoginBody extends ConsumerStatefulWidget {
  const LoginBody({super.key});

  @override
  ConsumerState<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends ConsumerState<LoginBody> {
  bool _obscureText = true;
  late LoginModel user;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    user = LoginModel();
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Map<String, dynamic>> checkState =
        ref.watch(loginUserProvider);
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
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ref.watch(isAuthenticatedTemp.notifier).state = true;
                        // context.canPop() ? context.pop() :
                        context.go('/');
                      });
                    }
                    return sondyaDisplaySuccessMessage(
                        context, data["message"]);
                  },
                  loading: () => const SizedBox(),
                  error: (error, stackTrace) =>
                      sondyaDisplayErrorMessage(error.toString(), context),
                ),
                const Text(
                  "Log in to Sondya",
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  "Enter your details Below",
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
                TextFormField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: " Enter your Password",
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  validator: isInputEmpty,
                  onSaved: (value) {
                    user.password = value!;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    // context.push('/home');
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();

                      await ref.read(loginUserProvider.notifier).loginUser(
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
                      : const Text("Login"),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Text("Don't have an account?"),
                        const SizedBox(width: 10.0),
                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: OutlinedButton(
                            onPressed: () {
                              context.push('/register');
                            },
                            child: const Text(
                              "Register",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const Text("Forgot Password?"),
                        const SizedBox(width: 10.0),
                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: OutlinedButton(
                            onPressed: () {
                              context.push('/forgotPassword');
                            },
                            child: const Text(
                              "Forgot Password?",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const AuthFooterImages(),
              ],
              // Your scrollable content here
            ),
          ),
        ),
      ),
    );
  }
}

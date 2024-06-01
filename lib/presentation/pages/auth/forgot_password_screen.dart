import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/config/style.dart';
import 'package:sondya_app/presentation/features/auth/forgotPassword/forgot_password_body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: buildAuthTheme(context),
      child: Scaffold(
        appBar: AppBar(
          leading: context.canPop()
              ? IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.arrow_back),
                )
              : IconButton(
                  onPressed: () {
                    context.push("/");
                  },
                  icon: const Icon(Icons.home),
                ),
          title: const Text("Forgot Password"),
        ),
        body: const ForgotPasswordBody(),
      ),
    );
  }
}

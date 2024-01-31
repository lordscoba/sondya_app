import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/widgets/circle_images.dart';

class ForgotPasswordBody extends StatefulWidget {
  const ForgotPasswordBody({super.key});

  @override
  State<ForgotPasswordBody> createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<ForgotPasswordBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          height: 650,
          width: 380,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const CircleImage(),
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
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Row(
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
                          onPressed: () {},
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
                          onPressed: () {},
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sondya_app/presentation/widgets/circle_images.dart';

class RegisterSuccessBody extends StatelessWidget {
  const RegisterSuccessBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const CircleImage(),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEDB842).withOpacity(.23),
                  borderRadius: BorderRadius.circular(1),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeData.light().scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(1),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Column(
                    children: [
                      const Text(
                        "Thanks for joining!",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEDB842),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "We will send you a confirmation code in your inbox. Copy and Paste to activate your account.",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {}, child: const Text("Home")),
                    ],
                  ),
                ),
              ),
              const Divider(),
              const AuthFooterImages(),
            ],
          ),
        ),
      ),
    );
  }
}

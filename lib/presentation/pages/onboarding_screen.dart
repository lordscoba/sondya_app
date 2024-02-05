import 'package:flutter/material.dart';
import 'package:sondya_app/data/onboarding_data.dart';
import 'package:sondya_app/presentation/features/onboarding/onboarding_body.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (context) => OnboardingDialog(onboardingPagesData),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(),
    );
  }
}

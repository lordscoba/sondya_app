import 'package:flutter/material.dart';
import 'package:sondya_app/domain/models/onboarding_pages_models.dart';

final List<OnboardingPageType> onboardingPagesData = [
  OnboardingPageType(
      "assets/images/onboarding_img1.png",
      "Get Best Shopping Experience",
      "Sondya Shopping is a platform that provides you with the best shopping experience. Our platform is made to help you with the best shopping experience.",
      Colors.white,
      Colors.black,
      Colors.white),
  OnboardingPageType(
      "assets/images/onboarding_img2.png",
      "Speedy Payment for all Services",
      "Sondya Shopping provides you with the best payment experience. We provide you with the best payment experience.",
      const Color(0xFFEDB842),
      Colors.black,
      const Color(0xFFEDB842)),
  OnboardingPageType(
      "assets/images/onboarding_img3.png",
      "Buy & Delivery",
      "Sondya Shopping provides you with the best delivery experience. We provide you with the best delivery experience.",
      Colors.black87,
      Colors.white,
      Colors.white),
];

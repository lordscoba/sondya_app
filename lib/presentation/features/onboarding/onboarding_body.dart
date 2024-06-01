import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/domain/models/onboarding_pages_models.dart';
import 'package:sondya_app/domain/providers/hasInit.provider.dart';

class OnboardingDialog extends ConsumerStatefulWidget {
  final List<OnboardingPageType> pages;

  const OnboardingDialog(this.pages, {super.key});

  @override
  ConsumerState<OnboardingDialog> createState() => _OnboardingDialogState();
}

class _OnboardingDialogState extends ConsumerState<OnboardingDialog> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (currentIndex > 0) {
          setState(() {
            currentIndex--;
          });
        } else {
          context.push('/welcome');
        }
      },
      child: Scaffold(
        backgroundColor: widget.pages[currentIndex].color,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: widget.pages[currentIndex]
                .textColor, // Set the color of the leading icon
          ),
          actions: [
            TextButton(
              onPressed: () {
                ref.read(hasInitAppProvider.notifier).update1(true);
                context.push('/');
              },
              child: Text(
                "Skip",
                style: TextStyle(color: widget.pages[currentIndex].textColor),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: double.infinity,
              height: 700,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image(
                    image: AssetImage(widget.pages[currentIndex].image),
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      textAlign: TextAlign.center,
                      widget.pages[currentIndex].title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: widget.pages[currentIndex].textColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Text(
                      widget.pages[currentIndex].description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: widget.pages[currentIndex].textColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: GestureDetector(
                      onTap: () {
                        if (currentIndex < widget.pages.length - 1) {
                          setState(() {
                            currentIndex++;
                          });
                        } else {
                          ref.read(hasInitAppProvider.notifier).update1(true);
                          context.push('/');
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Image(
                            image: AssetImage("assets/shapes/circle_25.png"),
                          ),
                          CircleAvatar(
                            backgroundColor:
                                widget.pages[currentIndex].buttonColor,
                            radius: 25.0,
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.black87,
                              size: 30.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

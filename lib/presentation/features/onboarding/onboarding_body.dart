import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/domain/models/onboarding_pages_models.dart';

class OnboardingDialog extends StatefulWidget {
  final List<OnboardingPageType> pages;

  const OnboardingDialog(this.pages, {super.key});

  @override
  State<OnboardingDialog> createState() => _OnboardingDialogState();
}

class _OnboardingDialogState extends State<OnboardingDialog> {
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
                context.push('/welcome');
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
                    height: 400,
                    width: double.infinity,
                  ),
                  SizedBox(
                    width: 275,
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
                    width: 275,
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
                          context.push('/welcome');
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

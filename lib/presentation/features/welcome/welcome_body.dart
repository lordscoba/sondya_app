import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sondya_app/presentation/widgets/circle_images.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          height: 980,
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Image(
                    image: AssetImage(
                      'assets/images/welcome_img.png',
                    ),
                    fit: BoxFit.contain,
                    height: 400,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Seamless',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: ' Shopping \nExperience',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: 275,
                    child: Text(
                      'Lorem ipsum dolor sit amet consectetur. Quis porta arcu habitant ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: () {
                      // context.push('/register');
                      context.push('/onboarding');
                    },
                    child: const Text("Let`s Get Started"),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, '/login');
                      context.push('/login');
                    },
                    child: const Text("Already have an account? Log in"),
                  ),
                  const CircleImageRight()
                ],
              )
            ],
            // Your scrollable content here
          ),
        ),
      ),
    );
  }
}

class CircleImages {
  const CircleImages();
}

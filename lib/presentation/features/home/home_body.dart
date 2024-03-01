import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/presentation/features/home/home_body_sections.dart';

class HomeBody extends ConsumerWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SingleChildScrollView(
      child: Center(
        child: SizedBox(
          height: 1200,
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              HomeProductsList(),
              HomeToGroupChat(),
              HomeServicesList(),
            ],
            // Your scrollable content here
          ),
        ),
      ),
    );
  }
}

class HomeToGroupChat extends StatelessWidget {
  const HomeToGroupChat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Connect with buyers/sellers around the globe",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Get Started"),
                  ),
                ),
              ],
            ),
          ),
          Image(
            image: const AssetImage(
              'assets/images/people_and_friends.png',
            ),
            fit: BoxFit.contain,
            height: 200,
            width: MediaQuery.of(context).size.width * 0.45,
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/local/storedValue.dart';
import 'package:sondya_app/data/storage_constants.dart';
import 'package:sondya_app/utils/copy.dart';

class ReferralPageBody extends ConsumerWidget {
  const ReferralPageBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storedAuthValue =
        ref.watch(storedValueProvider(EnvironmentStorageConfig.authSession));
    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              const Text(
                "Refer a friend! Give \$20, Get \$20",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC749),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text(
                  "Already 57682 CUSTOMERS SHARED THIS OFFER WITH FRIENDS",
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(height: 40.0),
              const Text(
                  "Get your referral link to give your friends a \$20 off discount when they shop at Hot Beans. If they use it, we’ll reward you with \$20 too!"),
              const SizedBox(height: 20.0),
              const Text(
                "Share the love",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.send),
                  ),
                  const Text("Invite your friends to Sondya."),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.shopping_cart),
                  ),
                  const Text("Your friends get 20% off their first purchase"),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.card_giftcard),
                  ),
                  const SizedBox(
                    width: 300.0,
                    child: Text(
                        "You get \$20 for every friend that makes a \$50 purchase"),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              const Text("Or copy your personal link"),
              const SizedBox(height: 10.0),
              storedAuthValue.when(
                data: (dataR) {
                  Map<String, dynamic> data = {};
                  if (dataR.isNotEmpty) {
                    data = jsonDecode(dataR);
                  }
                  TextEditingController controller = TextEditingController(
                    text:
                        'https://www.sondya.com/register?referrer=${data["email"] ?? ""}',
                  );
                  return TextField(
                    controller: controller,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Personal link',
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.copy,
                        ),
                        onPressed: () {
                          copyToClipboard(controller.text);
                        },
                      ),
                    ),
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) => Text(error.toString()),
              ),
              const SizedBox(height: 10.0),
              const Text("Invite now using:"),
              const SizedBox(height: 10.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.facebook),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.telegram),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.mail),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Invite Now"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

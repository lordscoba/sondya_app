import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TrackOrderBody extends StatefulWidget {
  const TrackOrderBody({super.key});

  @override
  State<TrackOrderBody> createState() => _TrackOrderBodyState();
}

class _TrackOrderBodyState extends State<TrackOrderBody> {
  String orderId = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Track Order",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                  "To track your order please enter your order ID in the input field below and press the “Track Order” button. this was given to you on your receipt and in the confirmation email you should have received."),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Order ID",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: "ID...",
                  // labelText: 'Code',
                ),
                onChanged: (value) {
                  setState(() {
                    orderId = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Icon(Icons.info_outline_rounded),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      width: 300,
                      child: Text(
                          "Order ID that we sended to your in your email address."))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.push("/track/details/$orderId");
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Track Order"),
                      Icon(Icons.arrow_forward),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

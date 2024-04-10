import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InboxBody extends ConsumerStatefulWidget {
  const InboxBody({super.key});

  @override
  ConsumerState<InboxBody> createState() => _InboxBodyState();
}

class _InboxBodyState extends ConsumerState<InboxBody> {
  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          // height: 1200,
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
              const SizedBox(height: 20.0),
              const Text(
                "Inbox",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              const TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  // labelText: 'Code',
                ),
              ),
              const SizedBox(height: 20.0),
              const Text("No Conversations Yet..."),
              const SizedBox(height: 20.0),
              Container(
                height: 400,
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text("Pick a User to Chat with..."),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

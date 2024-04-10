import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InboxChatBody extends ConsumerStatefulWidget {
  const InboxChatBody({super.key});

  @override
  ConsumerState<InboxChatBody> createState() => _InboxChatBodyState();
}

class _InboxChatBodyState extends ConsumerState<InboxChatBody> {
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
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(height: 20.0),
              const Text(
                "Inbox",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              Container(
                height: MediaQuery.of(context).size.height - 370,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(10),
                          topEnd: Radius.circular(10),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.person),
                          SizedBox(width: 10.0),
                          Column(
                            children: [
                              Text("User Name"),
                              Row(
                                children: [
                                  Icon(Icons.circle,
                                      color: Colors.green, size: 10),
                                  SizedBox(width: 5.0),
                                  Text("Active now"),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Icon(Icons.delete),
                        ],
                      ),
                    ),
                    const Center(
                        child: Text("This is a new chat. No messages yet")),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        // labelText: 'Code',
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.send),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

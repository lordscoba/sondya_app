import 'package:flutter/material.dart';

class SellerChatBox extends StatelessWidget {
  const SellerChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(12.0),
      // add border decoration
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.black38, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).colorScheme.background,
        // add shadow
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Chat with seller"),
          Divider(),
          BorderTextForChat(
            text: "👋 Hey Extreme Design, can you help me with...",
          ),
          BorderTextForChat(
            text: "Would it be possible to get a custom offer for...",
          ),
          BorderTextForChat(
            text: "Do you think you can deliver an order by...",
          ),
          Divider(),
          TextField(
            decoration: InputDecoration(
              hintText: "Enter Message",
              border: InputBorder.none,
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: null,
                    iconSize: 25,
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: null,
                    iconSize: 25,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BorderTextForChat extends StatelessWidget {
  final String text;
  const BorderTextForChat({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black38,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sondya_app/presentation/features/groupchat/groupchat_view_file.dart';

class GroupChatSnippet extends StatelessWidget {
  final String? senderName;
  final String? text;
  final String? time;
  final String? image;
  const GroupChatSnippet(
      {super.key, this.senderName, required this.text, this.time, this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                image!,
              ),
              fit: BoxFit.cover,
            ),
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 3.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          width: 300,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 260,
                child: Text(
                  senderName ?? "Unknown",
                  style: const TextStyle(fontSize: 12, color: Colors.white54),
                ),
              ),
              const SizedBox(height: 5.0),
              SizedBox(
                width: 260,
                child: Text(
                  text ?? "Unknown",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 5.0),
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 120,
                  child: Text(
                    time ?? "unknown",
                    style: const TextStyle(fontSize: 10, color: Colors.white54),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GroupChatSnippet2 extends StatelessWidget {
  final String? text;
  final String? time;
  const GroupChatSnippet2({super.key, required this.text, this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: 350,
      decoration: BoxDecoration(
        color: const Color(0xFFEDB842),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 260,
              child: Text(
                text ?? "Unknown",
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 120,
              child: Text(
                time ?? "unknown",
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GroupChatImageSnippet extends StatelessWidget {
  final String? senderName;
  final String? text;
  final String? time;
  final String? image;
  final String? imageChat;
  const GroupChatImageSnippet(
      {super.key,
      this.senderName,
      required this.text,
      this.time,
      this.image,
      this.imageChat});

  @override
  Widget build(BuildContext context) {
    final Uint8List imageBytes = base64Decode(imageChat!);
    return Row(
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                image!,
              ),
              fit: BoxFit.cover,
            ),
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 3.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          width: 300,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 260,
                child: Text(
                  senderName ?? "Unknown",
                  style: const TextStyle(fontSize: 12, color: Colors.white54),
                ),
              ),
              const SizedBox(height: 5.0),
              if (imageChat != null)
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Image.memory(imageBytes, fit: BoxFit.cover),
                  ),
                ),
              const SizedBox(height: 5.0),
              SizedBox(
                width: 260,
                child: Text(
                  text ?? "Unknown",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 5.0),
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 120,
                  child: Text(
                    time ?? "unknown",
                    style: const TextStyle(fontSize: 10, color: Colors.white54),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GroupChatImageSnippet2 extends StatelessWidget {
  final String? text;
  final String? time;
  final String? imageChat;
  const GroupChatImageSnippet2(
      {super.key, required this.text, this.time, this.imageChat});

  @override
  Widget build(BuildContext context) {
    final Uint8List imageBytes = base64Decode(imageChat!);
    // return Image.memory(imageBytes);
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: 350,
      decoration: BoxDecoration(
        color: const Color(0xFFEDB842),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          if (imageChat != null)
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Image.memory(imageBytes, fit: BoxFit.cover),
              ),
            ),
          const SizedBox(height: 5.0),
          SizedBox(
            width: 260,
            child: Text(
              text ?? "Unknown",
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          const SizedBox(height: 5.0),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 120,
              child: Text(
                time ?? "unknown",
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GroupChatFileSnippet extends StatelessWidget {
  final String? senderName;
  final String? text;
  final String? time;
  final String? image;
  final String? fileChat;
  final String? fileName;
  final int? fileSize;
  final String? fileExtension;
  const GroupChatFileSnippet(
      {super.key,
      this.senderName,
      required this.text,
      this.time,
      this.image,
      this.fileChat,
      this.fileName,
      this.fileSize,
      this.fileExtension});

  @override
  Widget build(BuildContext context) {
    final Uint8List fileBytes = base64Decode(fileChat!);
    return Row(
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                image!,
              ),
              fit: BoxFit.cover,
            ),
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 3.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          width: 300,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 260,
                child: Text(
                  senderName ?? "Unknown",
                  style: const TextStyle(fontSize: 12, color: Colors.white54),
                ),
              ),
              const SizedBox(height: 5.0),
              if (fileExtension == "jpg" || fileExtension == "png")
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Image.memory(fileBytes, fit: BoxFit.cover),
                  ),
                ),
              if (fileExtension?.toLowerCase() == "pdf")
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        Expanded(
                          child: FileDownloader(
                            fileBytes: fileBytes,
                            fileName: fileName!,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 5.0),
              SizedBox(
                width: 260,
                child: Text(
                  text ?? "Unknown",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 5.0),
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 120,
                  child: Text(
                    time ?? "unknown",
                    style: const TextStyle(fontSize: 10, color: Colors.white54),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GroupChatFileSnippet2 extends StatelessWidget {
  final String? text;
  final String? time;
  final String? fileChat;
  final String? fileName;
  final int? fileSize;
  final String? fileExtension;
  const GroupChatFileSnippet2(
      {super.key,
      required this.text,
      this.time,
      this.fileChat,
      this.fileName,
      this.fileSize,
      this.fileExtension});

  @override
  Widget build(BuildContext context) {
    // final Uint8List imageBytes = base64Decode(imageChat!);
    // return Image.memory(imageBytes);

    final Uint8List fileBytes = base64Decode(fileChat!);
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: 350,
      decoration: BoxDecoration(
        color: const Color(0xFFEDB842),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          if (fileChat != null)
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Image.memory(fileBytes, fit: BoxFit.cover),
                // child: Text(fileChat.toString()),
              ),
            ),
          const SizedBox(height: 5.0),
          if (fileExtension == "jpg" || fileExtension == "png")
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Image.memory(fileBytes, fit: BoxFit.cover),
              ),
            ),
          if (fileExtension?.toLowerCase() == "pdf")
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    Expanded(
                      child: FileDownloader(
                        fileBytes: fileBytes,
                        fileName: fileName!,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 5.0),
          SizedBox(
            width: 260,
            child: Text(
              text ?? "Unknown",
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          const SizedBox(height: 5.0),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 120,
              child: Text(
                time ?? "unknown",
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sondya_app/data/extra_constants.dart';
import 'package:sondya_app/presentation/features/groupchat/groupchat_view_file.dart';

class ChatSnippet extends StatelessWidget {
  final String? text;
  final String? time;
  final String? image;
  const ChatSnippet({super.key, required this.text, this.time, this.image});

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
                image ?? networkImagePlaceholder,
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
        ),
      ],
    );
  }
}

class ChatSnippet2 extends StatelessWidget {
  final String? text;
  final String? time;
  const ChatSnippet2({super.key, required this.text, this.time});

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

class ChatImageSnippet extends StatelessWidget {
  final bool isFromWeb;
  final String? text;
  final String? time;
  final String? image;
  final dynamic imageChat;
  const ChatImageSnippet(
      {super.key,
      required this.text,
      this.time,
      this.image,
      this.imageChat,
      this.isFromWeb = false});

  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytes;
    if (imageChat != null && imageChat is String && !isFromWeb) {
      imageBytes = base64Decode(imageChat);
    }
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
              if (imageChat != null)
                if (!isFromWeb)
                  GestureDetector(
                    onDoubleTap: () {
                      showGeneralDialog(
                        context: context,
                        transitionDuration: const Duration(
                            milliseconds: 100), // Adjust animation duration
                        transitionBuilder: (context, a1, a2, widget) {
                          return FadeTransition(
                            opacity: CurvedAnimation(
                                parent: a1, curve: Curves.easeIn),
                            child: widget,
                          );
                        },
                        barrierLabel: MaterialLocalizations.of(context)
                            .modalBarrierDismissLabel, // Optional accessibility label
                        pageBuilder: (context, animation1, animation2) {
                          return FilelargeView(
                            isFromWeb: false,
                            imageUrl: null,
                            imageBytes: imageBytes,
                          );
                        },
                      );
                    },
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: imageBytes != null
                            ? Image.memory(imageBytes, fit: BoxFit.cover)
                            : const SizedBox(),
                      ),
                    ),
                  ),
              if (imageChat != null)
                if (isFromWeb)
                  GestureDetector(
                    onDoubleTap: () {
                      showGeneralDialog(
                        context: context,
                        transitionDuration: const Duration(
                            milliseconds: 100), // Adjust animation duration
                        transitionBuilder: (context, a1, a2, widget) {
                          return FadeTransition(
                            opacity: CurvedAnimation(
                                parent: a1, curve: Curves.easeIn),
                            child: widget,
                          );
                        },
                        barrierLabel: MaterialLocalizations.of(context)
                            .modalBarrierDismissLabel, // Optional accessibility label
                        pageBuilder: (context, animation1, animation2) {
                          return FilelargeView(
                            isFromWeb: true,
                            imageUrl: imageChat[0]["url"],
                            imageBytes: null,
                          );
                        },
                      );
                    },
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Image.network(imageChat[0]["url"],
                            fit: BoxFit.cover),
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

class ChatImageSnippet2 extends StatelessWidget {
  final bool isFromWeb;
  final String? text;
  final String? time;
  final dynamic imageChat;
  const ChatImageSnippet2(
      {super.key,
      required this.text,
      this.time,
      this.imageChat,
      this.isFromWeb = false});

  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytes;
    if (imageChat != null && imageChat is String && !isFromWeb) {
      imageBytes = base64Decode(imageChat);
    }
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
            if (!isFromWeb)
              GestureDetector(
                onDoubleTap: () {
                  showGeneralDialog(
                    context: context,
                    transitionDuration: const Duration(
                        milliseconds: 100), // Adjust animation duration
                    transitionBuilder: (context, a1, a2, widget) {
                      return FadeTransition(
                        opacity:
                            CurvedAnimation(parent: a1, curve: Curves.easeIn),
                        child: widget,
                      );
                    },
                    barrierLabel: MaterialLocalizations.of(context)
                        .modalBarrierDismissLabel, // Optional accessibility label
                    pageBuilder: (context, animation1, animation2) {
                      return FilelargeView(
                        isFromWeb: false,
                        imageUrl: null,
                        imageBytes: imageBytes,
                      );
                    },
                  );
                },
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: imageBytes != null
                        ? Image.memory(imageBytes, fit: BoxFit.cover)
                        : const SizedBox(),
                  ),
                ),
              ),
          if (imageChat != null)
            if (isFromWeb)
              GestureDetector(
                onDoubleTap: () {
                  showGeneralDialog(
                    context: context,
                    transitionDuration: const Duration(
                        milliseconds: 100), // Adjust animation duration
                    transitionBuilder: (context, a1, a2, widget) {
                      return FadeTransition(
                        opacity:
                            CurvedAnimation(parent: a1, curve: Curves.easeIn),
                        child: widget,
                      );
                    },
                    barrierLabel: MaterialLocalizations.of(context)
                        .modalBarrierDismissLabel, // Optional accessibility label
                    pageBuilder: (context, animation1, animation2) {
                      return FilelargeView(
                        isFromWeb: true,
                        imageUrl: imageChat[0]["url"],
                        imageBytes: null,
                      );
                    },
                  );
                },
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child:
                        Image.network(imageChat[0]["url"], fit: BoxFit.cover),
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

class ChatFileSnippet extends StatelessWidget {
  final bool isFromWeb;
  final String? text;
  final String? time;
  final String? image;
  final dynamic fileChat;
  final String? fileName;
  final int? fileSize;
  final String? fileExtension;
  const ChatFileSnippet(
      {super.key,
      required this.text,
      this.time,
      this.image,
      this.fileChat,
      this.fileName,
      this.fileSize,
      this.fileExtension,
      this.isFromWeb = false});

  @override
  Widget build(BuildContext context) {
    // final Uint8List fileBytes = base64Decode(fileChat!);
    Uint8List? fileBytes;
    if (fileChat != null && fileChat is String && !isFromWeb) {
      fileBytes = base64Decode(fileChat);
    }
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
              if (!isFromWeb && fileBytes != null)
                if (fileExtension == "jpg" ||
                    fileExtension == "png" ||
                    fileExtension == "image/jpeg" ||
                    fileExtension == "image/png")
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Image.memory(fileBytes, fit: BoxFit.cover),
                    ),
                  ),
              if (!isFromWeb && fileBytes != null)
                if (fileExtension?.toLowerCase() != "jpg")
                  if (fileExtension?.toLowerCase() != "png")
                    if (fileExtension?.toLowerCase() != "image/jpeg")
                      if (fileExtension?.toLowerCase() != "image/png")
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            color: Colors.white,
                            child: FileDownloader(
                              fileBytes: fileBytes,
                              fileName: fileName!,
                            ),
                          ),
                        ),
              if (isFromWeb && fileChat != null)
                if (fileExtension == "jpg" ||
                    fileExtension == "png" ||
                    fileExtension == "image/jpeg" ||
                    fileExtension == "image/png")
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child:
                          Image.network(fileChat[0]["url"], fit: BoxFit.cover),
                    ),
                  ),
              if (isFromWeb && fileChat != null)
                if (fileExtension?.toLowerCase() != "jpg")
                  if (fileExtension?.toLowerCase() != "png")
                    if (fileExtension?.toLowerCase() != "image/jpeg")
                      if (fileExtension?.toLowerCase() != "image/png")
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            color: Colors.white,
                            child: FileDownloader(
                              isFromWeb: true,
                              fileBytes: null,
                              fileFromWeb: fileChat,
                              fileName: fileName!,
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

class ChatFileSnippet2 extends StatelessWidget {
  final bool isFromWeb;
  final String? text;
  final String? time;
  final dynamic fileChat;
  final String? fileName;
  final int? fileSize;
  final String? fileExtension;
  const ChatFileSnippet2(
      {super.key,
      required this.text,
      this.time,
      this.fileChat,
      this.fileName,
      this.fileSize,
      this.fileExtension,
      this.isFromWeb = false});

  @override
  Widget build(BuildContext context) {
    // final Uint8List fileBytes = base64Decode(fileChat!);
    Uint8List? fileBytes;
    if (fileChat != null && fileChat is String && !isFromWeb) {
      fileBytes = base64Decode(fileChat);
    }
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: 350,
      decoration: BoxDecoration(
        color: const Color(0xFFEDB842),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          if (!isFromWeb && fileBytes != null)
            if (fileExtension == "jpg" ||
                fileExtension == "png" ||
                fileExtension == "image/jpeg" ||
                fileExtension == "image/png")
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Image.memory(fileBytes, fit: BoxFit.cover),
                ),
              ),
          if (!isFromWeb && fileBytes != null)
            if (fileExtension?.toLowerCase() != "jpg")
              if (fileExtension?.toLowerCase() != "png")
                if (fileExtension?.toLowerCase() != "image/jpeg")
                  if (fileExtension?.toLowerCase() != "image/png")
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        color: Colors.white,
                        child: FileDownloader(
                          fileBytes: fileBytes,
                          fileName: fileName!,
                        ),
                      ),
                    ),
          if (isFromWeb && fileChat != null)
            if (fileExtension == "jpg" ||
                fileExtension == "png" ||
                fileExtension == "image/jpeg" ||
                fileExtension == "image/png")
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Image.network(fileChat[0]["url"], fit: BoxFit.cover),
                ),
              ),
          if (isFromWeb && fileChat != null)
            if (fileExtension?.toLowerCase() != "jpg")
              if (fileExtension?.toLowerCase() != "png")
                if (fileExtension?.toLowerCase() != "image/jpeg")
                  if (fileExtension?.toLowerCase() != "image/png")
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        color: Colors.white,
                        child: FileDownloader(
                          isFromWeb: true,
                          fileBytes: null,
                          fileFromWeb: fileChat,
                          fileName: fileName!,
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

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SondyaImageSelection extends StatefulWidget {
  const SondyaImageSelection({super.key});

  @override
  State<SondyaImageSelection> createState() => _SondyaImageSelectionState();
}

class _SondyaImageSelectionState extends State<SondyaImageSelection> {
  XFile? _image;
  dynamic _pickImageError;

  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
  }

  Future<void> _getImage() async {
    if (context.mounted) {
      try {
        final ImagePicker picker = ImagePicker();
        final XFile? image =
            await picker.pickImage(source: ImageSource.gallery);
        setState(() {
          _image = image;
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _getImage,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        color: Colors.grey,
        dashPattern: const [8, 4], // Adjust dash and space lengths
        strokeWidth: 2, // Adjust border width
        child: SizedBox(
          width: 380,
          height: 200,
          child: _image == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.image,
                      size: 50,
                      color: Color(0xFFEDB842),
                    ),
                    if (_pickImageError != null)
                      Text(_pickImageError.toString()),
                    const Text("Drag and drop image here, or click add image"),
                    GestureDetector(
                      onTap: _getImage,
                      child: Container(
                        width: 250,
                        height: 44,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDB842).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "Browse",
                          style:
                              TextStyle(color: Color(0xFFEDB842), fontSize: 18),
                        ),
                      ),
                    )
                  ],
                )
              : _getImageWidget(),
        ),
      ),
    );
  }

  Widget _getImageWidget() {
    if (kIsWeb) {
      // Display image for web
      return Image.network(
        _image!.path,
        fit: BoxFit.cover,
      );
    } else {
      // Display image for mobile
      return Image.file(
        File(_image!.path),
        fit: BoxFit.cover,
      );
    }
  }
}

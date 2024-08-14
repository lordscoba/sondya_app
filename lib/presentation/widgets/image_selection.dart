import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sondya_app/domain/models/home.dart';

class SondyaImageSelection extends StatefulWidget {
  final void Function(XFile value)? onSetImage;
  final String? savedNetworkImage;
  const SondyaImageSelection(
      {super.key, this.onSetImage, this.savedNetworkImage});

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
              ? widget.savedNetworkImage != null &&
                      widget.savedNetworkImage!.isNotEmpty
                  ? Image.network(
                      widget.savedNetworkImage!,
                      fit: BoxFit.cover,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.image,
                          size: 50,
                          color: Color(0xFFEDB842),
                        ),
                        if (_pickImageError != null)
                          Text(_pickImageError.toString()),
                        const Text(
                            "Drag and drop image here, or click add image"),
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
                              style: TextStyle(
                                  color: Color(0xFFEDB842), fontSize: 18),
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

  Future<void> _getImage() async {
    if (context.mounted) {
      try {
        final ImagePicker picker = ImagePicker();
        final XFile? image =
            await picker.pickImage(source: ImageSource.gallery);
        setState(() {
          _image = image;
        });

        // Invoke onSetImage if provided
        if (widget.onSetImage != null && image != null) {
          widget.onSetImage!(image);
        }
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }

  Widget _getImageWidget() {
    if (kIsWeb && widget.savedNetworkImage == null) {
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

class ProfilePicsSelector extends StatefulWidget {
  final void Function(XFile value)? onSetImage;
  final String? savedNetworkImage;
  const ProfilePicsSelector(
      {super.key, this.onSetImage, this.savedNetworkImage});

  @override
  State<ProfilePicsSelector> createState() => _ProfilePicsSelectorState();
}

class _ProfilePicsSelectorState extends State<ProfilePicsSelector> {
  XFile? _image;
  dynamic _pickImageError;

  @override
  void initState() {
    super.initState();
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _getImage,
      child: Container(
          width: 380,
          height: 200,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: _image == null
                  ? widget.savedNetworkImage != null &&
                          widget.savedNetworkImage!.isNotEmpty
                      ?
                      // Image.network(widget.savedNetworkImage!)
                      NetworkImage(widget.savedNetworkImage!) as ImageProvider
                      : const AssetImage("assets/images/placeholder.jpg")
                  : FileImage(File(_image!.path)),
              fit: BoxFit.cover,
            ),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_pickImageError != null)
                Text(
                  _pickImageError.toString(),
                ),
              IconButton(
                onPressed: _getImage,
                icon: const Icon(Icons.edit, color: Colors.black87, size: 30),
              )
            ],
          )),
    );
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

        // Invoke onSetImage if provided
        if (widget.onSetImage != null && image != null) {
          widget.onSetImage!(image);
        }
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }
}

// for multiple images
class SondyaMultipleImageSelection extends StatefulWidget {
  final void Function(List<XFile> value)? onSetImage;
  final void Function(List<String> value)? onSetDeletedImageId;
  final List<ImageType>? savedNetworkImage;
  final List<XFile>? savedFileImage;
  const SondyaMultipleImageSelection(
      {super.key,
      this.onSetImage,
      this.savedNetworkImage,
      this.savedFileImage,
      this.onSetDeletedImageId});

  @override
  State<SondyaMultipleImageSelection> createState() =>
      _SondyaMultipleImageSelectionState();
}

class _SondyaMultipleImageSelectionState
    extends State<SondyaMultipleImageSelection> {
  // image file
  List<XFile>? _image;

  // error variable
  dynamic _pickImageError;

  // deleted image id to be sent to backend server
  List<String> deletedImageId = [];

  // image network
  List<ImageType> _networkImage = [];

  @override
  void initState() {
    super.initState();
    _image = widget.savedFileImage;
    _networkImage = widget.savedNetworkImage ?? [];
    // Initialize the variable in initState
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _getImage,
      onDoubleTap: _getImage,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        color: Colors.grey,
        dashPattern: const [8, 4], // Adjust dash and space lengths
        strokeWidth: 2, // Adjust border width
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 200, minWidth: 380),
          child: _image == null || _image!.isEmpty
              ? _networkImage.isNotEmpty
                  ? _getNetworkImageWidget()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.image,
                          size: 50,
                          color: Color(0xFFEDB842),
                        ),
                        if (_pickImageError != null)
                          Text(_pickImageError.toString()),
                        const Text(
                            "Drag and drop image here, or click add image"),
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
                              style: TextStyle(
                                  color: Color(0xFFEDB842), fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    )
              : _networkImage.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Old Image(s)",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        _getNetworkImageWidget(),
                        const SizedBox(height: 10),
                        const Text(
                          "New Image(s)",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        _getImageWidget(),
                      ],
                    )
                  : _getImageWidget(),
        ),
      ),
    );
  }

  Future<void> _getImage() async {
    if (context.mounted) {
      try {
        final ImagePicker picker = ImagePicker();
        final List<XFile> image = await picker.pickMultiImage();
        List<XFile> newImage = _image ?? [];
        setState(() {
          for (var el in image) {
            newImage.add(el);
          }
          _image = newImage;
        });
        // Invoke onSetImage if provided
        if (widget.onSetImage != null && _image != null) {
          widget.onSetImage!(newImage);
        }
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
        // print(e);
      }
    }
  }

  Widget _getImageWidget() {
    if (kIsWeb && _networkImage.isEmpty) {
      // Display image for web
      if (_image != null && _image!.isNotEmpty) {
        return Wrap(
          spacing: 8.0, // Adjust as needed
          runSpacing: 8.0, // Adjust as needed
          children: _image!
              .map((xFile) => MultiImageItem(
                    onRemove: () {
                      setState(() {
                        _image!.remove(xFile);
                        widget.onSetImage!(_image!);
                      });
                    },
                    path: xFile.path,
                    isNetwork: false,
                    isWeb: true,
                  ))
              .toList(),
        );
      } else {
        return Container();
      }
    } else {
      // Display image for mobile
      if (_image != null && _image!.isNotEmpty) {
        return Wrap(
          spacing: 8.0, // Adjust as needed
          runSpacing: 8.0, // Adjust as needed
          children: _image!
              .map((xFile) => MultiImageItem(
                    onRemove: () {
                      setState(() {
                        _image!.remove(xFile);
                        widget.onSetImage!(_image!);
                      });
                    },
                    path: xFile.path,
                    isNetwork: false,
                    isWeb: false,
                  ))
              .toList(),
        );
      } else {
        return Container();
      }
    }
  }

  Widget _getNetworkImageWidget() {
    if (_networkImage.isNotEmpty) {
      return Wrap(
        spacing: 8.0, // Adjust spacing as needed
        runSpacing: 8.0, // Adjust run spacing as needed
        children: _networkImage.map((imageType) {
          return MultiImageItem(
            onRemove: () {
              setState(() {
                _networkImage.remove(imageType);

                deletedImageId.add(imageType.sId ?? "");
                widget.onSetDeletedImageId!(deletedImageId);
                // widget.onSetImage!(_networkImage);
              });
            },
            path: imageType.url!,
            isNetwork: true,
            isWeb: false,
          );
        }).toList(),
      );
    } else {
      return Container();
    }
  }
}

class MultiImageItem extends StatelessWidget {
  final bool isWeb;
  final bool isNetwork;
  final String path;
  final void Function()? onRemove;
  const MultiImageItem(
      {super.key,
      this.isNetwork = false,
      required this.path,
      this.isWeb = false,
      this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color(0xFFEDB842),
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          if (isNetwork || isWeb)
            Image.network(
              path,
              fit: BoxFit.cover,
              height: 200,
              width: 110,
            )
          else
            Image.file(
              File(path),
              fit: BoxFit.cover,
              height: 200,
              width: 110,
            ),
          Positioned(
            top: 0,
            right: 4,
            child: Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: onRemove,
                icon: const Icon(
                  size: 20,
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SondyaFileAttachmentWidget extends StatefulWidget {
  final void Function(XFile value)? onSetImage;
  final void Function(FilePickerResult value)? onSetFile;
  const SondyaFileAttachmentWidget(
      {super.key, this.onSetImage, this.onSetFile});

  @override
  State<SondyaFileAttachmentWidget> createState() =>
      _SondyaFileAttachmentWidgetState();
}

class _SondyaFileAttachmentWidgetState
    extends State<SondyaFileAttachmentWidget> {
  // for image and files
  XFile? _image;
  dynamic _pickImageError;
  FilePickerResult? _result;
  // image and files ends here

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("File Attachment"),
      ),
      extendBody: true,
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_image == null && _result == null && _pickImageError == null)
              Wrap(
                children: [
                  const ListTile(
                    title: Text(
                      'Select an attachment!',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text('Camera'),
                    onTap: () {
                      _pickImage(ImageSource.camera, context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      _pickImage(ImageSource.gallery, context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.insert_drive_file),
                    title: const Text('Document'),
                    onTap: () {
                      _pickDocument(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.location_on),
                    title: const Text('Location'),
                    onTap: () {
                      // Handle location sharing
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text('Go Back'),
                    ),
                  ),
                ],
              ),
            if (_image != null || _result != null)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            "${_image?.name ?? _result?.files.first.name}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _image = null;
                              _result = null;
                              _pickImageError = null;
                            });
                          },
                          icon: const Icon(Icons.close),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    _getImageWidget(),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () {
                        if (_image != null) {
                          widget.onSetImage!(_image!);
                        } else if (_result != null) {
                          widget.onSetFile!(_result!);
                        }

                        // close the bottom sheet
                        context.pop();
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Share'),
                          SizedBox(width: 10),
                          Icon(Icons.share),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            if (_pickImageError != null)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: const Text(
                            " Error Message",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _image = null;
                              _result = null;
                              _pickImageError = null;
                            });
                          },
                          icon: const Icon(Icons.close),
                        )
                      ],
                    ),
                    Text('Error picking image: ${_pickImageError.toString()}'),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Future<XFile?> _pickImage(ImageSource source, BuildContext context) async {
    if (context.mounted) {
      try {
        final ImagePicker picker = ImagePicker();
        final XFile? pickedFile = await picker.pickImage(source: source);

        // Check if image is picked
        if (pickedFile != null) {
          setState(() {
            _image = pickedFile;
          });
          // Handle the image file
          // print('Picked image: ${pickedFile.path}');
        }
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
    return null;
  }

  Future<void> _pickDocument(BuildContext context) async {
    if (context.mounted) {
      try {
        final FilePickerResult? result = await FilePicker.platform.pickFiles();

        // Check if document is picked
        if (result != null) {
          setState(() {
            _result = result;
          });
          // Handle the selected file
          // print('Picked document: ${result.files.single.path}');
        }
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }

  Widget _getImageWidget() {
    if (_image != null) {
      return Image.file(
        File(_image!.path),
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height * 0.2,
      );
    }
    if (_result != null) {
      return Column(
        children: [
          Text(
            _result!.files.first.extension!,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Text(
            _result!.files.first.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}

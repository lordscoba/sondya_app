import 'dart:io';
import 'dart:typed_data';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileDownloader extends StatefulWidget {
  final bool isFromWeb;
  final Uint8List? fileBytes;
  final String fileName;
  final List<dynamic>? fileFromWeb;

  const FileDownloader(
      {super.key,
      required this.fileBytes,
      required this.fileName,
      this.isFromWeb = false,
      this.fileFromWeb = const []});

  @override
  State<FileDownloader> createState() => _FileDownloaderState();
}

class _FileDownloaderState extends State<FileDownloader> {
  String? filePath;
  bool fileDownloaded = false;
  bool isDownloading = false;
  bool isFromWeb = false;
  List<dynamic>? fileFromWeb = [];

  @override
  void initState() {
    super.initState();
    isFromWeb = widget.isFromWeb;
    fileFromWeb = widget.fileFromWeb;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Row(
        children: [
          Icon(Icons.file_copy_outlined, color: Colors.grey.shade700),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (fileDownloaded) {
                  openFile();
                } else {
                  if (isFromWeb) {
                    saveFileFromUrl(
                        fileFromWeb?[0]["url"], fileFromWeb?[0]["filename"]);
                  } else {
                    saveFileFromBytes();
                  }
                }
              },
              child: isDownloading
                  ? const CupertinoActivityIndicator(
                      radius: 10,
                    )
                  : Text(
                      fileDownloaded
                          ? 'View File'
                          : 'Download \n ${widget.fileName}',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> saveFileFromBytes() async {
    if ((Platform.isAndroid &&
            await requestManageExternalStoragePermission()) ||
        (Platform.isIOS && await requestStoragePermission())) {
      try {
        setState(() {
          isDownloading = true;
        });

        // Save the file
        Directory directory = await getApplicationDocumentsDirectory();
        setState(() {
          filePath = '${directory.path}/${widget.fileName}';
        });
        File file = File(filePath!);
        await file.writeAsBytes(widget.fileBytes!);

        setState(() {
          fileDownloaded = true;
          isDownloading = false;
        });

        // ignore: use_build_context_synchronously
        AnimatedSnackBar.rectangle(
          'File downloaded successfully',
          "File saved to $filePath",
          type: AnimatedSnackBarType.success,
          brightness: Brightness.light,
        ).show(
          context,
        );
      } catch (e) {
        print('Error saving file: $e');

        // ignore: use_build_context_synchronously
        AnimatedSnackBar.rectangle(
          'Failed to save file',
          "Error: $e",
          type: AnimatedSnackBarType.warning,
          brightness: Brightness.light,
        ).show(
          context,
        );
        setState(() {
          isDownloading = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      AnimatedSnackBar.rectangle(
        'Storage permission denied',
        "Please grant storage permission",
        type: AnimatedSnackBarType.warning,
        brightness: Brightness.light,
      ).show(
        context,
      );
      setState(() {
        isDownloading = false;
      });
    }
  }

  // Future<void> saveFileFromUrl(String url, String fileName) async {
  //   // Check storage permission
  //   if ((Platform.isAndroid &&
  //           await requestManageExternalStoragePermission()) ||
  //       (Platform.isIOS && await requestStoragePermission())) {
  //     try {
  //       setState(() {
  //         isDownloading = true;
  //       });

  //       // Download the file using Dio
  //       final dio = Dio();
  //       final response = await dio.get(url,
  //           options: Options(responseType: ResponseType.bytes));

  //       // Check for successful download
  //       if (response.statusCode == 200) {
  //         final bytes = response.data;

  //         // Save the file
  //         final directory = await getApplicationDocumentsDirectory();
  //         setState(() {
  //           filePath = '${directory.path}/$fileName';
  //         });
  //         File file = File(filePath!);
  //         await file.writeAsBytes(bytes);

  //         setState(() {
  //           fileDownloaded = true;
  //           isDownloading = false;
  //         });

  //         // Show success snackbar
  //         // ignore: use_build_context_synchronously
  //         AnimatedSnackBar.rectangle(
  //           'File downloaded successfully',
  //           "File saved to $filePath",
  //           type: AnimatedSnackBarType.success,
  //           brightness: Brightness.light,
  //         ).show(
  //           context,
  //         );
  //       } else {
  //         throw Exception(
  //             'Failed to download file. Status code: ${response.statusCode}');
  //       }
  //     } catch (e) {
  //       // print('Error saving file: $e');

  //       // Show error snackbar
  //       // ignore: use_build_context_synchronously
  //       AnimatedSnackBar.rectangle(
  //         'Failed to save file',
  //         "Error: $e",
  //         type: AnimatedSnackBarType.warning,
  //         brightness: Brightness.light,
  //       ).show(
  //         context,
  //       );

  //       setState(() {
  //         isDownloading = false;
  //       });
  //     }
  //   } else {
  //     // Show permission denied snackbar
  //     // ignore: use_build_context_synchronously
  //     AnimatedSnackBar.rectangle(
  //       'Storage permission denied',
  //       "Please grant storage permission",
  //       type: AnimatedSnackBarType.warning,
  //       brightness: Brightness.light,
  //     ).show(
  //       context,
  //     );

  //     setState(() {
  //       isDownloading = false;
  //     });
  //   }
  // }

  Future<void> saveFileFromUrl(String url, String fileName) async {
    if ((Platform.isAndroid &&
            await requestManageExternalStoragePermission()) ||
        (Platform.isIOS && await requestStoragePermission())) {
      try {
        setState(() {
          isDownloading = true;
        });

        // Get the application documents directory
        Directory directory = await getApplicationDocumentsDirectory();
        setState(() {
          filePath = '${directory.path}/$fileName';
        });

        // Initialize Dio
        Dio dio = Dio();

        // Download the file and save it directly to the device storage
        await dio.download(
          url,
          filePath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              print(
                  'Downloading: ${(received / total * 100).toStringAsFixed(0)}%');
            }
          },
        );

        setState(() {
          fileDownloaded = true;
          isDownloading = false;
        });

        // ignore: use_build_context_synchronously
        AnimatedSnackBar.rectangle(
          'File downloaded successfully',
          "File saved to $filePath",
          type: AnimatedSnackBarType.success,
          brightness: Brightness.light,
        ).show(
          context,
        );
      } catch (e) {
        print('Error saving file: $e');

        // ignore: use_build_context_synchronously
        AnimatedSnackBar.rectangle(
          'Failed to save file',
          "Error: $e",
          type: AnimatedSnackBarType.warning,
          brightness: Brightness.light,
        ).show(
          context,
        );

        setState(() {
          isDownloading = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      AnimatedSnackBar.rectangle(
        'Storage permission denied',
        "Please grant storage permission",
        type: AnimatedSnackBarType.warning,
        brightness: Brightness.light,
      ).show(
        context,
      );
      setState(() {
        isDownloading = false;
      });
    }
  }

  Future<bool> requestManageExternalStoragePermission() async {
    bool isGranted = await Permission.manageExternalStorage.isGranted;

    if (isGranted) {
      return true;
    } else {
      // Request permission
      PermissionStatus status =
          await Permission.manageExternalStorage.request();

      if (status.isGranted) {
        return true;
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
        return false;
      } else {
        return false;
      }
    }
  }

  Future<bool> requestStoragePermission() async {
    // Check if the permission is already granted
    if (await Permission.storage.isGranted) {
      return true;
    }

    // Request permission
    PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      return false;
    } else {
      return false;
    }
  }

  void openFile() {
    if (filePath != null) {
      OpenFilex.open(filePath!);
    }
  }
}

class FilelargeView extends StatelessWidget {
  final bool? isFromWeb;
  final String? imageUrl;
  final Uint8List? imageBytes;
  const FilelargeView(
      {super.key, this.isFromWeb = false, this.imageUrl, this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Image"),
      ),
      extendBody: true,
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            isFromWeb!
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(imageUrl!, fit: BoxFit.cover),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width,
                    child: imageBytes != null
                        ? Image.memory(imageBytes!, fit: BoxFit.cover)
                        : const SizedBox(),
                  ),
          ],
        ),
      ),
    );
  }
}

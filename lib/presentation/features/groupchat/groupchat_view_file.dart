import 'dart:io';
import 'dart:typed_data';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileDownloader extends StatefulWidget {
  final Uint8List fileBytes;
  final String fileName;

  const FileDownloader(
      {super.key, required this.fileBytes, required this.fileName});

  @override
  State<FileDownloader> createState() => _FileDownloaderState();
}

class _FileDownloaderState extends State<FileDownloader> {
  String? filePath;
  bool fileDownloaded = false;
  bool isDownloading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Row(
        children: [
          Icon(Icons.file_copy_outlined, color: Colors.grey.shade700),
          const SizedBox(width: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: ElevatedButton(
              onPressed: fileDownloaded ? openFile : saveFile,
              child: isDownloading
                  ? const CupertinoActivityIndicator(
                      radius: 10,
                    )
                  : Text(fileDownloaded
                      ? 'View File'
                      : 'Download \n ${widget.fileName}'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> saveFile() async {
    // if (await _requestPermission(Permission.storage)) {
    if ((Platform.isAndroid &&
            await requestManageExternalStoragePermission()) ||
        (Platform.isIOS && await requestStoragePermission())) {
      try {
        setState(() {
          isDownloading = true;
        });

        // Save the file
        Directory directory = await getApplicationDocumentsDirectory();
        filePath = '${directory.path}/${widget.fileName}';
        File file = File(filePath!);
        await file.writeAsBytes(widget.fileBytes);

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

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileDownloader extends StatefulWidget {
  final Uint8List fileBytes;
  final String fileName;

  const FileDownloader(
      {super.key, required this.fileBytes, required this.fileName});

  @override
  _FileDownloaderState createState() => _FileDownloaderState();
}

class _FileDownloaderState extends State<FileDownloader> {
  Future<void> saveFile() async {
    // Request permission to write to external storage
    if (await _requestPermission(Permission.storage)) {
      try {
        // Get the directory to save the file (external storage directory)
        Directory directory = await getApplicationDocumentsDirectory();

        // Create the file path
        String filePath = '${directory.path}/${widget.fileName}';

        // Create the file in the directory
        File file = File(filePath);

        // Write the fileBytes to the file
        await file.writeAsBytes(widget.fileBytes);

        // Notify the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File saved to $filePath')),
        );
      } catch (e) {
        print('Error saving file: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save file')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied')),
      );
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      return result == PermissionStatus.granted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Downloader'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: saveFile,
          child: Text('Download ${widget.fileName}'),
        ),
      ),
    );
  }
}

// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:open_filex/open_filex.dart';
// import 'package:path_provider/path_provider.dart';

// class FileViewer extends StatefulWidget {
//   final Uint8List fileBytes;
//   final String fileName;

//   const FileViewer(
//       {super.key, required this.fileBytes, required this.fileName});

//   @override
//   State<FileViewer> createState() => _FileViewerState();
// }

// class _FileViewerState extends State<FileViewer> {
//   String? filePath;

//   @override
//   void initState() {
//     super.initState();
//     saveFile();
//   }

//   Future<void> saveFile() async {
//     try {
//       // Get the directory to save the file
//       Directory directory = await getApplicationDocumentsDirectory();

//       // Create the file in the directory
//       File file = File('${directory.path}/${widget.fileName}');

//       // Write the fileBytes to the file
//       await file.writeAsBytes(widget.fileBytes);

//       // Store the file path for later use
//       setState(() {
//         filePath = file.path;
//       });

//       // Optionally open the file automatically
//       OpenFilex.open(filePath!);
//     } catch (e) {
//       print('Error saving file: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('File Viewer'),
//       ),
//       body: Center(
//         child: filePath != null
//             ? ElevatedButton(
//                 onPressed: () {
//                   // Open the file if not opened automatically
//                   OpenFilex.open(filePath!);
//                 },
//                 child: Text('Open ${widget.fileName}'),
//               )
//             : const CircularProgressIndicator(),
//       ),
//     );
//   }
// }

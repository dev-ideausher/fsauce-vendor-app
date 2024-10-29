import 'dart:io';

import 'package:fsauce_vendor_app/app/services/snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:intl/intl.dart';

class FSVutil {
  static Future<XFile?> compressImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    final originalImage = File(pickedFile!.path);
    final targetPath = originalImage.path;
    final directory = originalImage.parent;
    final fileName = 'compressed_${originalImage.uri.pathSegments.last}';
    final compressedPath =
        '${directory.path}/$fileName'; // Ensure it ends with .jpg
    final compressedImage = await FlutterImageCompress.compressAndGetFile(
        targetPath, compressedPath,
        quality: 10);
    if (compressedImage != null) {
      return XFile(compressedImage.path);
    } else {
      // Compression failed, handle the error
      showMySnackbar(
          msg:
              "Oops! Something went wrong. Please try again and ensure your file is in JPG format.");
      return null;
    }
  }

  static String formatDate(DateTime timestamp) {
    final localTimestamp = timestamp.toLocal();
    return DateFormat('MMM d, yyyy, HH:mm').format(localTimestamp);
  }
}

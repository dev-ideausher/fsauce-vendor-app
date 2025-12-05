import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showMySnackbar({String? title, required String msg}) {
  final scaffoldMessenger =
      Get.context != null ? ScaffoldMessenger.maybeOf(Get.context!) : null;

  if (scaffoldMessenger != null) {
    scaffoldMessenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: _SnackBarContent(
            title: title ?? "Message",
            message: msg,
          ),
          duration: const Duration(milliseconds: 2000),
        ),
      );
    return;
  }

  if (Get.isSnackbarOpen == true) return;

  if (Get.overlayContext == null) {
    debugPrint('Skipping snackbar: No overlay found for message: $msg');
    return;
  }

  Get.rawSnackbar(
    titleText: Text(
      title ?? "Message",
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
    ),
    messageText: Text(
      msg,
      style: const TextStyle(color: Colors.white),
    ),
    duration: const Duration(milliseconds: 2000),
  );
}

class _SnackBarContent extends StatelessWidget {
  const _SnackBarContent({required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Text(message),
      ],
    );
  }
}

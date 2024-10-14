import 'package:ban_x/utils/constants/banx_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelperFunctions {

  static void showSnackBar(String msg) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(msg)));
  }

  static void showAlertDialog({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    Get.defaultDialog(
      title: title,
      content: Column(
        children: [
          Text(message),
        ],
      ),
      confirm: TextButton(
        onPressed: () {
          if (onConfirm != null) {
            onConfirm();
          }
          Get.back();
        },
        child: Text(confirmText ?? BanXString.ok),
      ),
      cancel: TextButton(
        onPressed: () {
          if (onCancel != null) {
            onCancel();
          }
          Get.back(); // Close the dialog
        },
        child: Text(cancelText ?? BanXString.cancel),
      ),
    );
  }

  static void navigateToScreen(Widget screen){
    Get.to(() => screen);
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }
}
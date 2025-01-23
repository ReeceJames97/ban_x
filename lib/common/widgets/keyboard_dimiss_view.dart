import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget keyboardDismissView({required Widget child}) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => Get.focusScope?.unfocus(),
    child: child,
  );
}

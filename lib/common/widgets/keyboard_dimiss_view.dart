import 'package:flutter/material.dart';

Widget keyboardDismissView(
    {required Widget child, required BuildContext context}) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => FocusScope.of(context).unfocus(),
    child: child,
  );
}

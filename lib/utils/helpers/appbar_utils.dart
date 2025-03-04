import 'dart:io';

import 'package:ban_x/utils/constants/banx_colors.dart';
import 'package:ban_x/utils/constants/banx_sizes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar getAppbar(String title,
    {Color? backgroundColor, List<Widget>? actionWidget}) {
  Widget richTitle = RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: "Ban", // White text
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20, // Adjust as needed
            fontWeight: FontWeight.normal,
          ),
        ),
        TextSpan(
          text: "X", // Bold Red text
          style: const TextStyle(
            color: Colors.red,
            fontSize: 22, // Slightly larger if needed
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );

  if (!kIsWeb && Platform.isAndroid) {
    return AppBar(
      elevation: 5,
      title: richTitle,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      systemOverlayStyle: getStatusBarStyle(),
      actions: actionWidget,
      backgroundColor: backgroundColor ?? BanXColors.appBarColor,
    );
  } else {
    return AppBar(
      elevation: 5,
      title: richTitle,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      systemOverlayStyle: getStatusBarStyle(),
      actions: actionWidget,
      toolbarHeight: BanXSizes.appBarHeight,
      backgroundColor: backgroundColor ?? BanXColors.appBarColor,
    );
  }
}

SystemUiOverlayStyle getStatusBarStyle(){
  return const SystemUiOverlayStyle(
      statusBarColor: BanXColors.darkBackground,
      statusBarBrightness: Brightness.dark
  );
}
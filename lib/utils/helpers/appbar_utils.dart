import 'dart:io';

import 'package:ban_x/utils/constants/banx_colors.dart';
import 'package:ban_x/utils/constants/banx_sizes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar getAppbar(String title,
    {Color? backgroundColor, List<Widget>? actionWidget}) {
  if( !kIsWeb && Platform.isAndroid){
    return AppBar(
      elevation: 5,
      title: Text(title, style: const TextStyle(color: Colors.white),),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      systemOverlayStyle: getStatusBarStyle(),
      actions: actionWidget,
      backgroundColor: backgroundColor ?? BanXColors.primaryColor,
    );
  }else{
    return AppBar(
      elevation: 5,
      title: Text(title, style: const TextStyle(color: Colors.white),),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      systemOverlayStyle: getStatusBarStyle(),
      actions: actionWidget,
      toolbarHeight: BanXSizes.appBarHeight,
      backgroundColor: backgroundColor ?? BanXColors.primaryColor,
    );
  }

}

SystemUiOverlayStyle getStatusBarStyle(){
  return const SystemUiOverlayStyle(
      statusBarColor: BanXColors.darkBackground,
      statusBarBrightness: Brightness.dark
  );
}
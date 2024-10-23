import 'dart:io';
import 'package:ban_x/utils/constants/banx_colors.dart';
import 'package:ban_x/utils/constants/banx_sizes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar getAppbar(String title,{List<Widget>? actionWidget}){

  if( !kIsWeb && Platform.isAndroid){
    return AppBar(
      elevation: 5,
      title: Text(title),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      systemOverlayStyle: getStatusBarStyle(),
      actions: actionWidget,
      backgroundColor: BanXColors.primaryColor,
    );
  }else{
    return AppBar(
      elevation: 5,
      title: Text(title),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      systemOverlayStyle: getStatusBarStyle(),
      actions: actionWidget,
      toolbarHeight: BanXSizes.appBarHeight,
      backgroundColor: BanXColors.primaryColor,
    );
  }

}

SystemUiOverlayStyle getStatusBarStyle(){
  return const SystemUiOverlayStyle(
      statusBarColor: BanXColors.darkBackground,
      statusBarBrightness: Brightness.dark
  );
}
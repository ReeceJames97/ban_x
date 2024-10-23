import 'package:ban_x/utils/constants/banx_colors.dart';
import 'package:ban_x/utils/constants/banx_sizes.dart';
import 'package:flutter/material.dart';

MaterialButton customStandardBtn(String text,
    {Function? callBack, bool isEnable = true, Color? buttonColor}) {
  return MaterialButton(
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(
              color: isEnable
                  ? buttonColor ?? BanXColors.primaryBtnColor
                  : Colors.grey)),
      minWidth: double.infinity,
      height: BanXSizes.buttonHeight,
      color: buttonColor ?? BanXColors.primaryBtnColor,
      disabledColor: BanXColors.disabledBtnColor,
      onPressed: isEnable
          ? () {
              if (callBack != null) {
                callBack();
              }
            }
          : null,
      child: Center(
        child: Text(text,
            style: TextStyle(
              fontSize: BanXSizes.fontSizeLg,
                color: isEnable ? Colors.white : Colors.black,
            )),
      ));
}

import 'package:ban_x/utils/constants/banx_colors.dart';
import 'package:ban_x/utils/constants/banx_sizes.dart';
import 'package:ban_x/utils/constants/banx_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

AlertDialog? mAlertDialog;
Dialog? mDialog;

void showConfirmDialog(Function confirmCallBack) {
  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: BanXColors.dialogBackground,
      title: const Text(
        BanXString.confirm,
        style: TextStyle(
          color: BanXColors.primaryTextColor,
            fontWeight: FontWeight.bold),
      ),
      content: const Text(BanXString.areYouSureYouWantToDoThis,
      style: TextStyle(
          color: BanXColors.primaryTextColor,
          fontWeight: FontWeight.bold
      ),),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text(
            BanXString.no,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: BanXColors.primaryTextColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            confirmCallBack();
          },
          child: const Text(
            BanXString.yes,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: BanXColors.primaryTextColor,
            ),
          ),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}

Future<void> showLoadingDialog() async {

  mDialog = Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    backgroundColor: BanXColors.dialogBackground,
    child: Container(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      width: BanXSizes.loadingLargeSize,
      height: BanXSizes.loadingMedianSize,
      child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: BanXColors.lightBackground,
          size: 50,
        ),
      ),
    ),
  );

  Get.dialog(
    mDialog!,
    barrierDismissible: false,
  );
}


void hideDialog() {
  if (mDialog != null) {
    mDialog = null;
    Get.back(closeOverlays: true);
  }

}


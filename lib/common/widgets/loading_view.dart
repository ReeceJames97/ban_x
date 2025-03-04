import 'package:ban_x/utils/constants/banx_colors.dart';
import 'package:ban_x/utils/constants/banx_sizes.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
  }
}
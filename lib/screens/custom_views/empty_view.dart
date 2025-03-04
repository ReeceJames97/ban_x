import 'package:ban_x/common/widgets/loading_view.dart';
import 'package:ban_x/utils/constants/banx_colors.dart';
import 'package:ban_x/utils/constants/banx_sizes.dart';
import 'package:ban_x/utils/constants/banx_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

Widget getEmptyViewWithRetry(Function retryCallback,bool isFirst, {String? message, String? title, bool isAnimate = false, String? buttonText, Color buttonColor = BanXColors.primaryBackground}){
  if (isFirst){
    return Container(
      alignment: Alignment.center,
      child: LoadingView(),
    );
  }else {
    return Container(
      alignment: Alignment.center,
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: BanXSizes.xxl
            ),

            (isAnimate)?Container(
              child: Lottie.asset('assets/lotties/empty_box.json',
                  width: 150,
                  height: 130,
                  animate: true,
                  repeat: true,
                  fit: BoxFit.fill),
            ):SvgPicture.asset(
              "assets/images/ic_empty.svg",
              matchTextDirection: true,
              width: BanXSizes.emptyJsonSize,
              height: BanXSizes.emptyJsonSize,
            ),


            SizedBox(
              height: BanXSizes.lg
            ),
            Text(
              (title != null && title.isNotEmpty) ? title : BanXString.emptyData,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: BanXSizes.xl,
                  fontWeight: FontWeight.bold,
                  color: BanXColors.secondaryTextColor
              ),
            ),
            SizedBox(
              height: BanXSizes.lg
            ),
            Text(
              (message == null || message == "") ? BanXString.nothingToShow : message,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: BanXSizes.lg,
                  color: BanXColors.secondaryTextColor
              ),
            ),

            SizedBox(
              height: 50,
            ),


            SizedBox(
                width: 400,
                height: 70,
                child:ElevatedButton(
                  onPressed: (){
                    retryCallback();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: Text((buttonText != null && buttonText.isNotEmpty)?buttonText:BanXString.tryAgain,
                      style: TextStyle(fontSize: BanXSizes.fontSizeXxl)),
                )

            ),
          ],
        ),
      ),
    );
  }
}
import 'package:ban_x/controllers/splash_controller/splash_screen_controller.dart';
import 'package:ban_x/utils/constants/banx_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashScreenController>(
        init: SplashScreenController(),
        builder: (controller) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: BanXColors.dialogBackground,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Lottie.asset('assets/lotties/splash_screen.json',
                          width: 300,
                          height: 250,
                          animate: true,
                          repeat: true,
                          fit: BoxFit.fill),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

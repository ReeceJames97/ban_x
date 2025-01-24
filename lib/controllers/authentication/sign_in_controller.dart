import 'package:ban_x/screens/authentication/sign_up_screen.dart';
import 'package:ban_x/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  RxBool isRememberMe = false.obs;
  RxBool isPasswordVisible = false.obs;

  void onTapSignIn() {
    HelperFunctions.showSnackBar("Sign In Button Tapped");
  }

  void onTapSignUp() {
    HelperFunctions.navigateToScreenWithReplacement(const SignUpScreen());
  }

  /// Update isRememberMe
  void updateRememberMe(bool? newValue) {
    isRememberMe = (newValue ?? false).obs;
    update();
  }

  ///Update isPasswordVisible
  void updatePasswordVisible() {
    isPasswordVisible = (!isPasswordVisible.value).obs;
    update();
  }

  void onTapCreateText() {
    HelperFunctions.navigateToScreenWithReplacement(const SignUpScreen());
  }
}
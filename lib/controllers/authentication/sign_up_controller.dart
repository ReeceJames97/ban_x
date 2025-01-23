import 'package:ban_x/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  RxBool isPasswordVisible = false.obs;
  RxBool isAgreeToTerms = false.obs;

  void onTapSignUp() {
    HelperFunctions.showSnackBar("Sign In Button Tapped");
  }

  ///Update isPasswordVisible
  void updatePasswordVisible() {
    isPasswordVisible = (!isPasswordVisible.value).obs;
    update();
  }

  ///Update isAgreeToTerms
  void updateAgreeToTerms(bool? newValue) {
    isAgreeToTerms = (newValue ?? false).obs;
    update();
  }
}

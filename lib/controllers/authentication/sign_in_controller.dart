import 'package:ban_x/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();

  void onTapSignIn() {
    HelperFunctions.showSnackBar("Sign In Button Tapped");
  }

  void onTapSignUp() {
    HelperFunctions.showSnackBar("Sign In Button Tapped");
  }
}
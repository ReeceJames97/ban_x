import 'package:ban_x/controllers/authentication/auth_controller.dart';
import 'package:ban_x/screens/authentication/sign_up_screen.dart';
import 'package:ban_x/screens/main_navigator.dart';
import 'package:ban_x/utils/common_utils.dart';
import 'package:ban_x/utils/constants/banx_constants.dart';
import 'package:ban_x/utils/constants/banx_strings.dart';
import 'package:ban_x/utils/dialog_utils/dialog.dart';
import 'package:ban_x/utils/helpers/helper_functions.dart';
import 'package:ban_x/utils/logger/logger_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  RxBool isRememberMe = false.obs;
  RxBool isPasswordVisible = false.obs;

  ///Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  late SharedPreferences? prefs;

  final txtPasswordController = TextEditingController();
  final txtEmailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initialization();
  }

  Future<void> initialization() async{
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    txtEmailController.dispose();
    txtPasswordController.dispose();
    super.dispose();
  }

  Future<void> onTapSignIn() async{
    String email = getEmptyString(txtEmailController.text.trim());
    String password = getEmptyString(txtPasswordController.text.trim());

    if (!GetUtils.isEmail(email)) {
      HelperFunctions.showSnackBar("Please enter a valid email address");
      return;
    }

    if (password.length < 6) {
      HelperFunctions.showSnackBar("Password should be at least 6 characters");
      return;
    }

    if (isNotNullEmptyString(email) && isNotNullEmptyString(password)) {
      try {
        showLoadingDialog();
        bool loginResult = await AuthController.instance.login(email, password);

        if (loginResult) {
          await prefs?.setString(BanXConstants.USER_EMAIL, email);
          if (isRememberMe.value) {
            await prefs?.setBool(BanXConstants.REMEMBER_ME, true);
          }
          update();
          hideDialog();
          HelperFunctions.showSnackBar(BanXString.loginSuccessfully);
          Get.off(() => const MainNavigator());
        } else {
          hideDialog();
          HelperFunctions.showSnackBar(BanXString.loginFailed);
        }
      } catch (e) {
        hideDialog();
        HelperFunctions.showSnackBar("An error occurred during login");
        LoggerUtils.debug('Login error: $e');
      }
    } else {
      HelperFunctions.showSnackBar(BanXString.plsEnterEmailAndPassword);
    }
  }

  /// Update isRememberMe
  void updateRememberMe(bool? newValue) {
    isRememberMe = (newValue ?? false).obs;
    update();
  }

  ///Update isPasswordVisible
  void updatePasswordVisible() {
    isPasswordVisible.value = !isPasswordVisible.value;
    update();
  }

  Future<void> loginWithGoogle() async {
    try {
      showLoadingDialog();

      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        hideDialog();
        HelperFunctions.showSnackBar("Google sign-in cancelled");
        return;
      }

      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;
      if (user == null) {
        throw Exception("Failed to sign in with Google");
      }

      await prefs?.setString(BanXConstants.USER_EMAIL, user.email ?? '');
      await prefs?.setString(BanXConstants.USER_NAME, user.displayName ?? '');
      if (isRememberMe.value) {
        await prefs?.setBool(BanXConstants.REMEMBER_ME, true);
      }

      hideDialog();
      Get.off(() => const MainNavigator());
      update();
    } catch (e) {
      hideDialog();
      HelperFunctions.showSnackBar("Error during Google sign-in: ${e.toString()}");
      LoggerUtils.debug('Google sign-in error: $e');
      update();
    }
  }

  void onTapCreateText() {
    Get.off(() => const SignUpScreen());
  }
}
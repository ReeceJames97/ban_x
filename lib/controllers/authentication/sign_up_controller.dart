import 'package:ban_x/controllers/authentication/auth_controller.dart';
import 'package:ban_x/screens/authentication/sign_in_screen.dart';
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

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  RxBool isPasswordVisible = false.obs;
  RxBool isAgreeToTerms = false.obs;

  final txtNameController = TextEditingController();
  final txtPasswordController = TextEditingController();
  final txtEmailController = TextEditingController();

  ///Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  late SharedPreferences? prefs;

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
    txtNameController.dispose();
    txtEmailController.dispose();
    txtPasswordController.dispose();
    super.dispose();
  }

  Future<void> onTapSignUp() async{
    String email = getEmptyString(txtEmailController.text.trim());
    String password = getEmptyString(txtPasswordController.text.trim());
    String name = getEmptyString(txtNameController.text.trim());

    if (!GetUtils.isEmail(email)) {
      HelperFunctions.showSnackBar("Please enter a valid email address");
      return;
    }

    if (password.length < 6) {
      HelperFunctions.showSnackBar("Password should be at least 6 characters");
      return;
    }

    if (name.isEmpty) {
      HelperFunctions.showSnackBar("Please enter your name");
      return;
    }

    if (!isAgreeToTerms.value) {
      HelperFunctions.showSnackBar("Please agree to the terms and conditions");
      return;
    }

    if (isNotNullEmptyString(email) && isNotNullEmptyString(password)) {
      try {
        showLoadingDialog();
        bool registrationResult = await AuthController.instance.register(email, password);

        if (registrationResult) {
          await prefs?.setString(BanXConstants.USER_EMAIL, email);
          await prefs?.setString(BanXConstants.USER_NAME, name);
          update();
          hideDialog();
          HelperFunctions.showSnackBar(BanXString.accCreatedSuccessfully);
          Get.off(() => const MainNavigator());
        } else {
          hideDialog();
          HelperFunctions.showSnackBar(BanXString.accCreationFailed);
        }
      } catch (e) {
        hideDialog();
        HelperFunctions.showSnackBar("An error occurred during registration");
        LoggerUtils.debug('Registration error: $e');
      }
    } else {
      HelperFunctions.showSnackBar(BanXString.plsEnterEmailAndPassword);
    }
  }

  Future<void> loginWithGoogle() async {
    if (!isAgreeToTerms.value) {
      HelperFunctions.showSnackBar("Please agree to the terms and conditions");
      return;
    }

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
      update();

      hideDialog();
      Get.off(() => const MainNavigator());
    } catch (e) {
      hideDialog();
      HelperFunctions.showSnackBar("Error during Google sign-in: ${e.toString()}");
      LoggerUtils.debug('Google sign-in error: $e');
    }
  }

  ///Update isPasswordVisible
  void updatePasswordVisible() {
    isPasswordVisible.value = !isPasswordVisible.value;
    update();
  }

  ///Update isAgreeToTerms
  void updateAgreeToTerms(bool? newValue) {
    isAgreeToTerms.value = newValue ?? false;
    update();
  }

  void onTapLoginText() {
    Get.off(() => const SignInScreen());
  }
}

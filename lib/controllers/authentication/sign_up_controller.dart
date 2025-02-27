import 'package:ban_x/controllers/authentication/auth_controller.dart';
import 'package:ban_x/screens/authentication/sign_in_screen.dart';
import 'package:ban_x/screens/main_navigator.dart';
import 'package:ban_x/utils/common_utils.dart';
import 'package:ban_x/utils/constants/banx_constants.dart';
import 'package:ban_x/utils/constants/banx_strings.dart';
import 'package:ban_x/utils/dialog_utils/dialog.dart';
import 'package:ban_x/utils/helpers/helper_functions.dart';
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
    txtEmailController.dispose();
    txtPasswordController.dispose();
    super.dispose();
  }

  Future<void> onTapSignUp() async{
    String email = getEmptyString(txtEmailController.text.trim().toString());
    String password =
    getEmptyString(txtPasswordController.text.trim().toString());

    if (password.length < 6) {
      HelperFunctions.showSnackBar("Password should be at least 6 characters");
      return;
    }
    if (isNotNullEmptyString(email) && isNotNullEmptyString(password)) {
      showLoadingDialog();
      bool registrationResult =
      await AuthController.instance.register(email, password);

      if (registrationResult) {
        prefs?.setString(BanXConstants.USER_EMAIL, email);
        update();
        hideDialog();
        HelperFunctions.showSnackBar(BanXString.accCreatedSuccessfully);
        Get.off(() => const MainNavigator());
      } else {
        hideDialog();
        HelperFunctions.showSnackBar(BanXString.accCreationFailed);
      }
    } else {
      HelperFunctions.showSnackBar(BanXString.plsEnterEmailAndPassword);
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      showLoadingDialog();
      final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      assert(!user!.isAnonymous);
      assert(await user?.getIdToken() != null);

      final User? currentUser = _auth.currentUser;
      assert(user?.uid == currentUser?.uid);
      hideDialog();

      Get.to(() => const MainNavigator());
    } catch (e) {
      hideDialog();
      // Handle and display the error
      HelperFunctions.showSnackBar("Error during Google sign-in: $e");
    }
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

  void onTapLoginText() {
    // HelperFunctions.navigateToScreenWithReplacement(const SignInScreen());
    Get.off(() => const SignInScreen());
  }
}

import 'package:ban_x/models/users_model.dart';
import 'package:ban_x/screens/authentication/sign_in_screen.dart';
import 'package:ban_x/utils/constants/banx_constants.dart';
import 'package:ban_x/utils/constants/banx_strings.dart';
import 'package:ban_x/utils/dialog_utils/dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainNavigatorController extends GetxController {
  final key = GlobalKey<ScaffoldState>();
  double screenHeight = 0;
  double screenWidth = 0;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final user = FirebaseAuth.instance.currentUser;
  String userMail = "";
  String userName = "";
  String photoUrl = "";
  RxString appBarTitle = BanXString.appName.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  late SharedPreferences? prefs;

  @override
  void onInit() {
    super.onInit();
    initialization();
  }

  initialization() async {
    screenWidth = MediaQuery.of(Get.context!).size.width;
    screenHeight = MediaQuery.of(Get.context!).size.height;
    prefs = await SharedPreferences.getInstance();

    if (user != null) {
      userMail = user!.email ?? "";
      userName = user!.displayName ?? "";
      photoUrl = user!.photoURL ?? "";

      await prefs?.setString(BanXConstants.USER_EMAIL, userMail);
      await prefs?.setString(BanXConstants.USER_NAME, userName);
      await prefs?.setString(BanXConstants.USER_PHOTO, photoUrl);
      await prefs?.setString(BanXConstants.USER_ID, user!.uid);

      UsersModel.userEmail = userMail;
      UsersModel.userId = user!.uid;

      if (kDebugMode) {
        print("User data updated: $userName, $userMail, $photoUrl");
      }
      update();
    }
  }

  ///Confirm Logout
  void confirmLogout() async{
    Get.back();
    await showLoadingDialog();

    Future.delayed(const Duration(seconds: 2), () {
      logout();
      hideDialog();
      update();
    });
  }

  ///Logout
  Future<void> logout() async {
    await auth.signOut();
    await googleSignIn.signOut();
    Get.off(() => const SignInScreen());
  }
}

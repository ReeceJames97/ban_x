import 'package:ban_x/screens/authentication/sign_in_screen.dart';
import 'package:ban_x/screens/main_navigator.dart';
import 'package:ban_x/utils/logger/logger_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> user;
  FirebaseAuth auth = FirebaseAuth.instance;
  RxString userEmail = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    LoggerUtils.debug('AuthController initialized');
    user = Rx<User?>(auth.currentUser);
    user.bindStream(auth.userChanges());
    ever(user, _initialScreen);
  }

  Future<void> _initialScreen(User? user) async {
    if (user != null) {
      final email = user.email;
      if (email != null && email.isNotEmpty) {
        userEmail.value = email;
        LoggerUtils.debug("Home Page");
        Get.off(() => const MainNavigator());
      } else {
        LoggerUtils.debug("Login Page");
        Get.off(() => const SignInScreen());
      }
    } else {
      LoggerUtils.debug("Login Page");
      Get.off(() => const SignInScreen());
    }
  }

  Future<void> checkAuthenticationStatus() async {
    try {
      isLoading.value = true;
      final currentUser = auth.currentUser;
      if (currentUser != null) {
        final email = currentUser.email;
        if (email != null && email.isNotEmpty) {
          userEmail.value = email;
          LoggerUtils.debug("Home Page");
          Get.off(() => const MainNavigator());
        } else {
          LoggerUtils.debug("Login Page");
          Get.off(() => const SignInScreen());
        }
      } else {
        LoggerUtils.debug("Login Page");
        Get.off(() => const SignInScreen());
      }
    } catch (e) {
      LoggerUtils.debug('Error checking authentication status: $e');
      Get.off(() => const SignInScreen());
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      isLoading.value = true;
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      if (result.user != null) {
        userEmail.value = email;
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      LoggerUtils.debug('Login error: ${e.message}');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> register(String email, String password) async {
    try {
      isLoading.value = true;
      final UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      if (result.user != null) {
        userEmail.value = email;
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      LoggerUtils.debug('Registration error: ${e.message}');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      isLoading.value = true;
      await auth.signOut();
      userEmail.value = '';
    } catch (e) {
      LoggerUtils.debug('Error during sign out: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

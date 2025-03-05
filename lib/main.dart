import 'package:ban_x/controllers/authentication/auth_controller.dart';
import 'package:ban_x/screens/splash/splash_screen.dart';
import 'package:ban_x/utils/themes/banx_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  ///Firebase Initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value) {
    Get.put(AuthController());
    // Get.put(MainNavigatorController());
  });
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: BanXTheme.lightTheme,
      darkTheme: BanXTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}


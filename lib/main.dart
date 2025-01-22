import 'package:ban_x/screens/authentication/sign_in_screen.dart';
import 'package:ban_x/utils/themes/banx_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
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
      home: const SignInScreen(),
    );
  }
}


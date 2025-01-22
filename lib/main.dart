import 'package:ban_x/utils/themes/banx_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: BanXTheme.lightTheme,
      darkTheme: BanXTheme.darkTheme,
    );
  }
}


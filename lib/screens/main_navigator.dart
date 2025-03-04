import 'package:ban_x/controllers/main_navigator_controller.dart';
import 'package:ban_x/screens/home_screen.dart';
import 'package:ban_x/screens/nav_bar.dart';
import 'package:ban_x/screens/settings_screen.dart';
import 'package:ban_x/utils/constants/banx_colors.dart';
import 'package:ban_x/utils/constants/banx_strings.dart';
import 'package:ban_x/utils/helpers/appbar_utils.dart';
import 'package:ban_x/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({Key? key}) : super(key: key);

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}


class _MainNavigatorState extends State<MainNavigator> {
  final MainNavigatorController controller = Get.put(MainNavigatorController());
  var crrTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: GetBuilder<MainNavigatorController>(
        init: MainNavigatorController(),
        builder: (_) => Scaffold(
          key: controller.key,
          appBar: getAppbar(BanXString.appName,
              backgroundColor: BanXColors.primaryBackground),
          drawer: const NavBar(),
          body: buildBodyView(controller.appBarTitle.value),
          resizeToAvoidBottomInset: true,
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (now.difference(crrTime) > const Duration(seconds: 2)) {
      crrTime = now;
      HelperFunctions.showSnackBar("Press Back Button Again to Exit");
      controller.update();
      // Close the drawer if open, otherwise proceed with back button logic
      if (controller.key.currentState?.isDrawerOpen ?? false) {
        controller.key.currentState?.openEndDrawer();
      } else {
        return Future.value(false); // Prevent immediate exit
      }
    } else {
      return Future.value(true); // Allow exit on second back press
    }
    return Future.value(true);
  }

  Widget buildBodyView(String title) {
    if (title == BanXString.appName) {
      controller.appBarTitle = BanXString.appName.obs;
      return const HomeScreen();
    } else {
      switch (title) {
        case "Home":
          controller.appBarTitle = "Home".obs;
          return const HomeScreen();

        case "Settings":
          controller.appBarTitle = "Settings".obs;
          return const SettingsScreen();

        default:
          controller.appBarTitle = BanXString.appName.obs;
          return const HomeScreen();
      }
    }
  }
}

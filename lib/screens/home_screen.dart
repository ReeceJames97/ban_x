import 'package:ban_x/utils/constants/banx_colors.dart';
import 'package:ban_x/utils/constants/banx_sizes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: getAppbar(BanXString.appName),
      body: SingleChildScrollView(
          child: Container(
        color: BanXColors.primaryBackground,
        margin: const EdgeInsets.all(BanXSizes.lg),
        child: Column(
          children: [],
        ),
      )),
    );
  }
}

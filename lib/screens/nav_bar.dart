import 'package:ban_x/controllers/main_navigator_controller.dart';
import 'package:ban_x/utils/constants/banx_colors.dart';
import 'package:ban_x/utils/constants/banx_sizes.dart';
import 'package:ban_x/utils/constants/banx_strings.dart';
import 'package:ban_x/utils/dialog_utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final MainNavigatorController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 5,
        child: Container(
          color: BanXColors.primaryBackground,
          child: ListView(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: BanXColors.primaryBackground,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: (controller.photoUrl.isNotEmpty)
                              ? CircleAvatar(
                              backgroundColor: BanXColors.primaryBackground,
                              radius: 42,
                              child: CircleAvatar(
                                  maxRadius: 40,
                                  backgroundImage:
                                  NetworkImage(controller.photoUrl)))
                              : CircleAvatar(
                            backgroundColor: BanXColors.primaryBackground,
                            radius: 42,
                            child: CircleAvatar(
                              maxRadius: 40,
                              backgroundColor: BanXColors.primaryBackground,
                              child: SvgPicture.asset(
                                'assets/images/profile.svg',
                                width: 90,
                                height: 90,
                              ),
                            ),
                          ),
                        ),

                        // const SizedBox(height: BanXSizes.sm),

                        ///Name
                        (controller.userName.isNotEmpty)
                            ? Expanded(
                          flex: 1,
                          child: Text(
                            controller.userName.toString(),
                            style: const TextStyle(
                                fontSize:
                                BanXSizes.md,
                                color: BanXColors.grey,
                                fontWeight: FontWeight.bold
                              // fontFamily: "NexaBold"
                            ),
                          ),
                        )
                            : const Text(
                          BanXString.name,
                          style: TextStyle(
                              fontSize:
                              BanXSizes.md,
                              color: BanXColors.grey,
                              fontWeight: FontWeight.bold
                            // fontFamily: "NexaBold"
                          ),
                        ),

                        // const SizedBox(height: BanXSizes.sm),

                        ///Email
                        (controller.userMail.isNotEmpty)
                            ? Expanded(
                          flex: 1,
                          child: Text(
                            controller.userMail.toString(),
                            style: const TextStyle(
                                fontSize:
                                BanXSizes.md,
                                color: BanXColors.grey,
                                fontWeight: FontWeight.bold
                              // fontFamily: "NexaBold"
                            ),
                          ),
                        )
                            : const Text(
                          BanXString.email,
                          style: TextStyle(
                              fontSize:
                              BanXSizes.md,
                              color: BanXColors.grey,
                              fontWeight: FontWeight.bold
                            // fontFamily: "NexaBold"
                          ),
                        ),

                        // const SizedBox(height: BanXSizes.sm),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    controller.appBarTitle = "CheckIn".obs;
                    controller.key.currentState?.closeDrawer();
                    controller.update();
                  },
                  leading:  Icon(MdiIcons.calendarCheck,
                      size: 30,
                      color: BanXColors.grey),
                  title: const Text('CheckIn',
                      style: TextStyle(
                          fontSize: BanXSizes.md,
                          color: BanXColors.grey
                      )),
                ),
                ListTile(
                  onTap: () {
                    controller.appBarTitle = "Profile".obs;
                    controller.key.currentState?.closeDrawer();
                    controller.update();
                  },
                  leading: Icon(MdiIcons.accountCircle,
                      size: 30,
                      color: BanXColors.grey),
                  title: const Text('Profile',
                      style: TextStyle(
                          fontSize: BanXSizes.md,
                          color: BanXColors.grey
                      )),
                ),
                ListTile(
                  onTap: () {
                    controller.appBarTitle = "Users".obs;
                    controller.key.currentState?.closeDrawer();
                    controller.update();
                  },
                  leading: const Icon(Icons.people,
                  size: 30,
                      color: BanXColors.grey),
                  title: const Text('Users',
                      style: TextStyle(
                        fontSize: BanXSizes.md,
                        color: BanXColors.grey
                      )),
                ),
                ListTile(
                  onTap: () {
                    controller.appBarTitle = "AttendanceHistory".obs;
                    controller.key.currentState?.closeDrawer();
                    controller.update();
                  },
                  leading: const Icon(Icons.history,
                      size: 30,
                      color: BanXColors.grey),
                  title: const Text('Attendance History',
                      style: TextStyle(
                          fontSize: BanXSizes.md,
                          color: BanXColors.grey
                      )),
                ),
                ListTile(
                  onTap: () {
                    controller.appBarTitle = "Settings".obs;
                    controller.key.currentState?.closeDrawer();
                    controller.update();
                  },
                  leading: const Icon(Icons.settings,
                      size: 30,
                      color: BanXColors.grey),
                  title: const Text('Settings',
                      style: TextStyle(
                          fontSize: BanXSizes.md,
                          color: BanXColors.grey
                      )),
                ),
                const SizedBox(
                  height: BanXSizes.md,
                ),
                const Divider(
                  color: Colors.black,
                  height: 1,
                  thickness: 1.0,
                  indent: 20.0,
                  endIndent: 10.0,
                ),
                const SizedBox(
                  height: BanXSizes.sm,
                ),
                ListTile(
                  onTap: () {
                    showConfirmDialog(controller.confirmLogout);
                  },
                  leading: const Icon(Icons.logout,
                      size: 30,
                      color: BanXColors.grey),
                  title: const Text(BanXString.logout,
                      style: TextStyle(
                          fontSize: BanXSizes.md,
                          color: BanXColors.grey
                      )),
                ),
              ]),
        ));
  }
}

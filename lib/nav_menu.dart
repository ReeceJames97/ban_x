import 'package:flutter/material.dart';

class NavMenu extends StatelessWidget {
  const NavMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(destinations: [
        Container(color: Colors.green, child: const Text("Home")),
        Container(color: Colors.red, child: const Text("Search")),
        Container(color: Colors.blue, child: const Text("Profile")),
      ], selectedIndex: 0),
    );
  }
}

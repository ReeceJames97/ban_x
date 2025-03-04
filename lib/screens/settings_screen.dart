import 'package:ban_x/utils/constants/banx_colors.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BanXColors.primaryBackground,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Account Settings Section
          const Text(
            'Account',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListTile(
            tileColor: Colors.white.withValues(alpha: 0.05),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: const Icon(Icons.person_outline, color: Colors.grey),
            title: const Text('Profile', style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
            onTap: () {},
          ),
          const SizedBox(height: 8),
          ListTile(
            tileColor: Colors.white.withValues(alpha: 0.05),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: const Icon(Icons.notifications_outlined, color: Colors.grey),
            title: const Text('Notifications', style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
            onTap: () {},
          ),

          // App Settings Section
          const SizedBox(height: 32),
          const Text(
            'App Settings',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListTile(
            tileColor: Colors.white.withValues(alpha: 0.05),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: const Icon(Icons.language, color: Colors.grey),
            title: const Text('Language', style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
            onTap: () {},
          ),
          const SizedBox(height: 8),
          ListTile(
            tileColor: Colors.white.withValues(alpha: 0.05),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: const Icon(Icons.dark_mode_outlined, color: Colors.grey),
            title: const Text('Theme', style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
            onTap: () {},
          ),

          // About Section
          const SizedBox(height: 32),
          const Text(
            'About',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListTile(
            tileColor: Colors.white.withValues(alpha: 0.05),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: const Icon(Icons.info_outline, color: Colors.grey),
            title: const Text('About App', style: TextStyle(color: Colors.white)),
            trailing: const Text('Version 1.0.0', style: TextStyle(color: Colors.grey, fontSize: 12)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

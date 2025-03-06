import 'package:ban_x/models/feedback_model.dart';
import 'package:ban_x/screens/profile_screen.dart';
import 'package:ban_x/services/api_services.dart';
import 'package:ban_x/utils/constants/banx_colors.dart';
import 'package:ban_x/utils/constants/banx_strings.dart';
import 'package:ban_x/utils/helpers/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  final ApiServices _apiServices = ApiServices();
  final user = FirebaseAuth.instance.currentUser;
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
            onTap: () => Get.to(() => const ProfileScreen()),
          ),
          // const SizedBox(height: 8),
          // ListTile(
          //   tileColor: Colors.white.withValues(alpha: 0.05),
          //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          //   leading: const Icon(Icons.notifications_outlined, color: Colors.grey),
          //   title: const Text('Notifications', style: TextStyle(color: Colors.white)),
          //   trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          //   onTap: () {},
          // ),

          // App Settings Section
          // const SizedBox(height: 32),
          // const Text(
          //   'App Settings',
          //   style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          // ),
          // const SizedBox(height: 16),
          // ListTile(
          //   tileColor: Colors.white.withValues(alpha: 0.05),
          //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          //   leading: const Icon(Icons.language, color: Colors.grey),
          //   title: const Text('Language', style: TextStyle(color: Colors.white)),
          //   trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          //   onTap: () {},
          // ),
          // const SizedBox(height: 8),
          // ListTile(
          //   tileColor: Colors.white.withValues(alpha: 0.05),
          //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          //   leading: const Icon(Icons.dark_mode_outlined, color: Colors.grey),
          //   title: const Text('Theme', style: TextStyle(color: Colors.white)),
          //   trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          //   onTap: () {},
          // ),

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
            onTap: () {
              HelperFunctions.showSnackBar(BanXString.appVersion);
            },
          ),
          const SizedBox(height: 8),
          ListTile(
            tileColor: Colors.white.withValues(alpha: 0.05),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: const Icon(Icons.feedback_outlined, color: Colors.grey),
            title: const Text('Send Feedback', style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: BanXColors.primaryBackground,
                  title: const Text('Send Feedback', style: TextStyle(color: Colors.white)),
                  content: TextField(
                    controller: _feedbackController,
                    style: const TextStyle(color: Colors.white),
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Write your feedback here...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[700]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        _feedbackController.clear();
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
                    ),
                    TextButton(
                      onPressed: () async {
                        if (_feedbackController.text.trim().isEmpty) {
                          HelperFunctions.showSnackBar(
                              'Please enter your feedback');
                          return;
                        }
                        
                        if (user == null) {
                          HelperFunctions.showSnackBar(
                              'Please sign in to submit feedback');
                          return;
                        }

                        final feedback = FeedbackModel(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          userId: user!.uid,
                          message: _feedbackController.text.trim(),
                          createdAt: DateTime.now(),
                        );

                        try {
                          await _apiServices.submitFeedback(feedback);
                          _feedbackController.clear();
                          Get.back();
                          HelperFunctions.showSnackBar(
                              'Thank you for your feedback!');
                        } catch (e) {
                          HelperFunctions.showSnackBar(
                              'Error submitting feedback: $e');
                        }
                      },
                      child: const Text('Submit', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

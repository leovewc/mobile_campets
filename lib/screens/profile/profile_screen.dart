import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constants.dart';
import 'components/profile_menu.dart';
import 'components/profile_pic.dart';
import 'my_account_screen.dart';
import 'notification.dart';
import 'help_center_screen.dart';
import 'setting_screen.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final userRef = FirebaseFirestore.instance.collection('users').doc(uid);

    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: userRef.snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('User data not found'));
          }
          final data = snapshot.data!.data()! as Map<String, dynamic>;
          final firstName = data['firstName'] as String? ?? 'User';

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top header with gradient and user info
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFB9B6D), Color(0xFFF76B1C)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(32),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    children: [
                      ProfilePic(),
                      const SizedBox(height: 16),
                      Text(
                        'Hello, $firstName!',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Menu items in cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      ProfileMenu(
                        text: "My Account",
                        icon: "assets/icons/User Icon.svg",
                        press: () => Navigator.pushNamed(
                          context,
                          MyAccountScreen.routeName,
                        ),
                      ),
                      const Divider(),
                      ProfileMenu(
                        text: "Notifications",
                        icon: "assets/icons/Bell.svg",
                        press: () => Navigator.pushNamed(
                          context,
                          NotificationScreen.routeName,
                        ),
                      ),
                      const Divider(),
                      ProfileMenu(
                        text: "Settings",
                        icon: "assets/icons/Settings.svg",
                        press: () => Navigator.pushNamed(
                          context,
                          SettingsScreen.routeName,
                        ),
                      ),
                      const Divider(),
                      ProfileMenu(
                        text: "Help Center",
                        icon: "assets/icons/Question mark.svg",
                        press: () => Navigator.pushNamed(
                          context,
                          HelpCenterScreen.routeName,
                        ),
                      ),
                      const Divider(),
                      ProfileMenu(
                        text: "Log Out",
                        icon: "assets/icons/Log out.svg",
                        press: () {
                          showDialog(
                            context: context,
                            builder: (_) => _buildLogoutDialog(context),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  AlertDialog _buildLogoutDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Center(child: Text('Log Out')),
      content: const Text(
        'Are you sure you want to log out?',
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You have been logged out.'),
                backgroundColor: kPrimaryColor,
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.of(context)
                .pushNamedAndRemoveUntil(
                  "/sign_in",
                  (route) => false,
                );
          },
          child: const Text(
            'Confirm',
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

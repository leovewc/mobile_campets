import 'package:flutter/material.dart';
import 'package:campets/screens/profile/help_center_screen.dart';
import 'package:campets/screens/profile/setting_screen.dart';
import '../../constants.dart';
import 'components/profile_menu.dart';
import 'components/profile_pic.dart';
import 'my_account_screen.dart';
import 'notification.dart';
import 'help_center_screen.dart';
import 'setting_screen.dart';
class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
           Text( 
              "Hello! Alex", 
              style: Theme.of(context).textTheme.titleLarge?.copyWith( 
              fontSize: 28, 
              color: const Color.fromARGB(255, 212, 64, 11).withOpacity(0.8), 
              ), 
              ), 
            const SizedBox(height: 80),
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: "assets/icons/User Icon.svg",
              press: ()  {
                Navigator.pushNamed(context, MyAccountScreen.routeName);
              },
            ),
            ProfileMenu(
              text: "Notifications",
              icon: "assets/icons/Bell.svg",
              press: () {
                Navigator.pushNamed(context, NotificationScreen.routeName);
              },
            ),
            ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              press: () {
                Navigator.pushNamed(context, SettingsScreen.routeName);
              },
            ),
            ProfileMenu(
              text: "Help Center",
              icon: "assets/icons/Question mark.svg",
              press: () {
                Navigator.pushNamed(context, HelpCenterScreen.routeName);
              },
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        dialogBackgroundColor: Colors.white,
                        dialogTheme: const DialogTheme(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                      child: AlertDialog(
                        titlePadding: const EdgeInsets.only(top: 24),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        title: Center(
                          child: Text(
                            "Log Out",
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: kTextColor,
                            ),
                          ),
                        ),
                        content: Text(
                          "Are you sure you want to log out?",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: kTextColor,
                          ),
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close dialog
                            },
                            child: Text("Cancel",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close dialog
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("You have been logged out."),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: kPrimaryColor,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
                                "/sign_in",
                                    (route) => false,
                              );
                            },
                            child: const Text("Confirm",
                            style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                            ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}

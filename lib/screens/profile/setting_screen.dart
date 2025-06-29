import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../components/showConfirmationDialog.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsScreen extends StatelessWidget {
  static String routeName = "/settings";

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
        elevation: 0,
        flexibleSpace: Container(
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
        ),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          // SettingSectionTitle(title: "Mode Switch"),
          // ModeSwitchTile(),
          // SizedBox(height: 24),
          SettingSectionTitle(title: "Payment Settings"),
          PaymentSwitchTile(),
          SizedBox(height: 24),
          SettingSectionTitle(title: "Notification Settings"),
          NotificationSettings(),
          SizedBox(height: 24),
          SettingSectionTitle(title: "Account & Privacy"),
          AccountPrivacySettings(),
          SizedBox(height: 24),
          SettingSectionTitle(title: "Experimental Features"),
          ExperimentalFeatures(),
          SizedBox(height: 24),
          SettingSectionTitle(title: "Language"),
          SizedBox(height: 18),
          LanguageDropdown(),
        ],
      ),
    );
  }
}

class SettingSectionTitle extends StatelessWidget {
  final String title;

  const SettingSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

// class ModeSwitchTile extends StatefulWidget {
//   const ModeSwitchTile({super.key});

//   @override
//   State<ModeSwitchTile> createState() => _ModeSwitchTileState();
// }

// class _ModeSwitchTileState extends State<ModeSwitchTile> {
//   int _selectedMode = 0;
//   final List<String> modes = ["Standard Mode", "Elderly Mode", "Child Mode"];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: List.generate(modes.length, (index) {
//         return RadioListTile<int>(
//           value: index,
//           groupValue: _selectedMode,
//           activeColor: Color(0xFFFF7643),
//           title: Text(modes[index]),
//           subtitle: index == 0
//               ? const Text("Rich in information and comprehensive in function")
//               : index == 1
//               ? const Text("Large characters and simple operations")
//               : const Text("Selected content and time control"),
//           onChanged: (value) {
//             setState(() {
//               _selectedMode = value!;
//             });
//           },
//         );
//       }),
//     );
//   }
// }

class PaymentSwitchTile extends StatefulWidget {
  const PaymentSwitchTile({super.key});

  @override
  State<PaymentSwitchTile> createState() => _PaymentSwitchTileState();
}

class _PaymentSwitchTileState extends State<PaymentSwitchTile> {
  bool _securePayment = false;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _securePayment,
      activeColor: Color(0xFFFF7643),
      title: const Text("Secure payment without password entry"),
      onChanged: (value) {
        setState(() {
          _securePayment = value;
        });
      },
    );
  }
}

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String _selectedLanguage = "English";
  final List<String> languages = [
    "English",
    "Chinese",
    "Malay",
    "Russian",
    "French",
    "Korean"
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedLanguage,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      icon: const Icon(Icons.language, color: Color(0xFFFF7643)),
      items: languages.map((lang) {
        return DropdownMenuItem<String>(
          value: lang,
          child: Text(lang),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedLanguage = value!;
        });
      },
    );
  }
}

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool promo = true;
  bool order = true;
  bool newProduct = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          title: const Text("Promotion Notifications"),
          value: promo,
          activeColor: Color(0xFFFF7643),
          onChanged: (value) => setState(() => promo = value),
        ),
        SwitchListTile(
          title: const Text("Order Updates"),
          value: order,
          activeColor: Color(0xFFFF7643),
          onChanged: (value) => setState(() => order = value),
        ),
        SwitchListTile(
          title: const Text("New Product Alerts"),
          value: newProduct,
          activeColor: Color(0xFFFF7643),
          onChanged: (value) => setState(() => newProduct = value),
        ),
      ],
    );
  }
}

class AccountPrivacySettings extends StatelessWidget {
  const AccountPrivacySettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text("Clear Browsing History"),
          leading: const Icon(Icons.history),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Browsing history cleared."),
                duration: Duration(seconds: 2),
                backgroundColor: kPrimaryColor,
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.delete_outline),
          title: Text("Delete Account"),
          onTap: () => showConfirmationDialog(
            context,
            "Delete Account",
            "Are you sure you want to delete your account?",
                () async {
                  try {
                    final user = FirebaseAuth.instance.currentUser;
                    final uid = user?.uid;

                    if (user != null && uid != null) {
                      // 删除 Firestore 用户文档
                      await FirebaseFirestore.instance.collection('users').doc(uid).delete();

                      // 删除 Firebase Auth 账户
                      await user.delete();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Account deleted successfully."),
                          duration: Duration(seconds: 2),
                          backgroundColor: kPrimaryColor,
                        ),
                      );

                      Navigator.of(context, rootNavigator: true)
                          .pushNamedAndRemoveUntil("/sign_in", (route) => false);
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Failed to delete account: ${e.toString()}"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Account deleted successfully."),
                  duration: Duration(seconds: 2),
                  backgroundColor: kPrimaryColor,
                ),
              );
              Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil("/sign_in", (route) => false);
            },
          ),
        ),
      ],
    );
  }
}

class ExperimentalFeatures extends StatefulWidget {
  const ExperimentalFeatures({super.key});

  @override
  State<ExperimentalFeatures> createState() => _ExperimentalFeaturesState();
}

class _ExperimentalFeaturesState extends State<ExperimentalFeatures> {
  bool beta = false;
  bool survey = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          title: const Text("Enable Beta Features"),
          value: beta,
          activeColor: Color(0xFFFF7643),
          onChanged: (value) => setState(() => beta = value),
        ),
        SwitchListTile(
          title: const Text("Receive Developer Surveys"),
          value: survey,
          activeColor: Color(0xFFFF7643),
          onChanged: (value) => setState(() => survey = value),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../sign_in/sign_in_screen.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../components/no_account_text.dart';
import '../../../constants.dart';

class GetYourPasswordScreen extends StatelessWidget {
  const GetYourPasswordScreen({super.key});

  static String routeName = "/get_password";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Email Sent")),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "A password reset link has been sent to your email.",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SignInScreen.routeName,
                      (route) => false, // 移除历史栈
                );
              },
              child: const Text("Back to Sign"),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    ),
    );
  }
}

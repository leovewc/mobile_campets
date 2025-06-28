import 'package:campets/constants.dart';
import 'package:flutter/material.dart';
import 'package:campets/screens/init_screen.dart';

class LoginSuccessScreen extends StatelessWidget {
  static String routeName = "/login_success";

  const LoginSuccessScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("  "),
      ),
      body: Column(
        children: [
          const SizedBox(height: 102),
          Image.asset(
            "assets/images/success_1.png",
            height: MediaQuery.of(context).size.height * 0.4, //40%
          ),
          const SizedBox(height: 48),
          const Text(
            "Login Success!",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, InitScreen.routeName);
              },
              child: const Text("Go to home"),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

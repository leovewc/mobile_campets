import 'package:flutter/material.dart';
import 'package:campets/screens/splash/splash_screen.dart';
import 'package:campets/screens/sign_in/sign_in_screen.dart';
import 'package:campets/screens/home/home_screen.dart';
import 'package:campets/screens/init_screen.dart';

import 'routes.dart';
import 'theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campets',
      theme: AppTheme.lightTheme(context),

      // ← 不再指定 home
      initialRoute: SplashScreen.routeName,

      // ← 直接引入你自己写好的 routes.dart
      routes: routes,
    );
  }
}

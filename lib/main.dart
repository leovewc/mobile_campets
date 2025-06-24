import 'package:flutter/material.dart';
import 'package:campets/screens/splash/splash_screen.dart';

import 'routes.dart';
import 'theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


import 'dart:convert';
import 'models/Product.dart'; // 请调整到你的实际路径

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
print('Firebase 已初始化, apps=${Firebase.apps.length}');
runApp(const MyApp());
  runApp(const MyApp());

  // // 直接打印所有产品的 JSON
  // final jsonStr = const JsonEncoder.withIndent('  ')
  //     .convert({ 'products': demoProducts.map((p) => p.toMap()).toList() });
  // print(jsonStr);
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Flutter Way - Template',
      theme: AppTheme.lightTheme(context),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}

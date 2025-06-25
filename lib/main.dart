import 'package:flutter/material.dart';
import 'package:campets/screens/splash/splash_screen.dart';
import 'package:campets/screens/sign_in/sign_in_screen.dart';
import 'package:campets/screens/home/home_screen.dart';

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
  print('Firebase 已初始化, apps=${Firebase.apps.length}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Flutter Way - Template',
      theme: AppTheme.lightTheme(context),

      // ← 只要一个 MaterialApp，所有路由写在 routes 里
      routes: routes,

      // ← 用 home 去切换三种状态
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          // 1) 等待 auth 初始化完成，显示你的 Dart 层 SplashScreen
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          // 2) 已登录，进首页
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          // 3) 未登录，进登录页
          return const SignInScreen();
        },
      ),
    );
  }
}

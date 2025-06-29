// lib/main.dart

import 'package:flutter/material.dart';
import 'package:campets/screens/splash/splash_screen.dart';
import 'package:campets/screens/sign_in/sign_in_screen.dart';
import 'package:campets/screens/home/home_screen.dart';
import 'package:campets/screens/init_screen.dart';

import 'routes.dart';
import 'theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:app_links/app_links.dart';
import 'dart:async';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri?>? _sub;

  @override
  void initState() {
    super.initState();
    _initDeepLink();
    // 监听运行时链接
    _sub = _appLinks.uriLinkStream.listen(
      (Uri? uri) => _handleIncomingLink(uri),
      onError: (err) => debugPrint('appLink Error: $err'),
    );
  }

  Future<void> _initDeepLink() async {
    try {
      final Uri? initialUri = await _appLinks.getInitialLink();
      _handleIncomingLink(initialUri);
    } catch (e) {
      debugPrint('init applink fail: $e');
    }
  }

  void _handleIncomingLink(Uri? uri) {
    if (uri == null) return;
    // 只处理 /reset 路径
    if (uri.host == 'campets.page.link' && uri.path == '/reset') {
      final code = uri.queryParameters['oobCode'];
      if (code != null) {
        navigatorKey.currentState?.pushNamed(
          '/reset_password',
          arguments: code,
        );
      }
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Campets',
      theme: AppTheme.lightTheme(context),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}

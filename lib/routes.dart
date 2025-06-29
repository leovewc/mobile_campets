import 'package:flutter/widgets.dart';
import 'package:campets/screens/products/products_screen.dart';
import 'package:campets/screens/profile/help_center_screen.dart';

import 'screens/cart/cart_screen.dart';
import 'screens/complete_profile/complete_profile_screen.dart';
import 'screens/details/details_screen.dart';
import 'screens/forgot_password/forgot_password_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/init_screen.dart';
import 'screens/login_success/login_success_screen.dart';
import 'screens/otp/otp_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/forgot_password/get_your_password_screen.dart';
import 'screens/profile/my_account_screen.dart';
import 'screens/profile/notification.dart';
import 'screens/profile/setting_screen.dart';
import 'screens/checkout/payment.dart';
import 'screens/forgot_password/reset_password.dart';
import 'screens/adoption/adoption_form_screen.dart';
// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  InitScreen.routeName: (context) => const InitScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  DetailsScreen.routeName: (context) => const DetailsScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  GetYourPasswordScreen.routeName: (context) => const GetYourPasswordScreen(),
  MyAccountScreen.routeName: (context) => const MyAccountScreen(),
  NotificationScreen.routeName: (context) => const NotificationScreen(),
  SettingsScreen.routeName: (context) => const SettingsScreen(),
  HelpCenterScreen.routeName: (context) => const HelpCenterScreen(),
  ProductsScreen.routeName: (context) => const ProductsScreen(),
  PaymentOptionPage.routeName: (context) => const PaymentOptionPage(),
  ResetPasswordScreen.routeName: (context) => const ResetPasswordScreen(),
  AdoptionFormScreen.routeName: (context) => const AdoptionFormScreen(petName: ""),
};


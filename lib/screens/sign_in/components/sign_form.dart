import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../helper/keyboard.dart';
import '../../forgot_password/forgot_password_screen.dart';
import '../../login_success/login_success_screen.dart';
import '../../sign_up/sign_up_screen.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email, password;
  bool remember = false, isLoading = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) setState(() => errors.add(error));
  }
  void removeError({String? error}) {
    if (errors.contains(error)) setState(() => errors.remove(error));
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    KeyboardUtil.hideKeyboard(context);
    setState(() => isLoading = true);

    try {
      // 1. 先查 Firestore，看邮箱是否存在
      final query = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email!.trim())
        .limit(1)
        .get();
      if (query.docs.isEmpty) {
        // Firestore 里没找到，提示注册
        _showRegisterDialog();
        return;
      }

      // 2. Firestore 找到，再尝试用 Firebase Auth 登录
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!.trim(),
        password: password!.trim(),
      );

      // 3. 登录成功，跳转
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          LoginSuccessScreen.routeName,
        );
      }

    } on FirebaseAuthException catch (e) {
      // 只要 Auth 登录失败，都当成“密码错误”
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Incorrect password. Please try again."),
          backgroundColor: kPrimaryColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      // 其他意外错误
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Unexpected error: $e"),
          backgroundColor: kPrimaryColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _showRegisterDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(
          "No account found. Please register first.",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: kTextColor),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, SignUpScreen.routeName);
            },
            child: const Text(
              "Register Now",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        // —— Email Field —— //
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          onSaved: (v) => email = v,
          onChanged: (v) {
            if (v.isNotEmpty) removeError(error: kEmailNullError);
            if (emailValidatorRegExp.hasMatch(v)) {
              removeError(error: kInvalidEmailError);
            }
          },
          validator: (v) {
            if (v == null || v.isEmpty) {
              addError(error: kEmailNullError);
              return "";
            }
            if (!emailValidatorRegExp.hasMatch(v)) {
              addError(error: kInvalidEmailError);
              return "";
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: "Email",
            hintText: "Enter your email",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
          ),
        ),
        const SizedBox(height: 20),

        // —— Password Field —— //
        TextFormField(
          obscureText: true,
          onSaved: (v) => password = v,
          onChanged: (v) {
            if (v.isNotEmpty) removeError(error: kPassNullError);
            if (v.length >= 8) removeError(error: kShortPassError);
          },
          validator: (v) {
            if (v == null || v.isEmpty) {
              addError(error: kPassNullError);
              return "";
            }
            if (v.length < 8) {
              addError(error: kShortPassError);
              return "";
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: "Password",
            hintText: "Enter your password",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
          ),
        ),
        const SizedBox(height: 20),

        // —— Remember & Forgot —— //
        Row(children: [
          Checkbox(
            value: remember,
            activeColor: kPrimaryColor,
            onChanged: (v) => setState(() => remember = v!),
          ),
          const Text("Remember me"),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              ForgotPasswordScreen.routeName,
            ),
            child: const Text(
              "Forgot Password",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
        ]),

        FormError(errors: errors),
        const SizedBox(height: 16),

        // —— Continue Button —— //
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: isLoading ? null : _login,
            child: isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  )
                : const Text("Continue"),
          ),
        ),
      ]),
    );
  }
}

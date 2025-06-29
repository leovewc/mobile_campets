// lib/screens/forgot_password/reset_password.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../constants.dart';                     
import '../sign_in/sign_in_screen.dart';           

class ResetPasswordScreen extends StatefulWidget {
  static const routeName = '/reset_password';

  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String _newPassword = '';
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    // oobCode
    final code = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Set New Password'),
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'New password (at least 6 characters)',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v != null && v.length >= 6) ? null : 'Password is too short',
                onSaved: (v) => _newPassword = v!.trim(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                  ),
                  onPressed: _loading ? null : () async {
                    if (!_formKey.currentState!.validate()) return;
                    _formKey.currentState!.save();
                    setState(() => _loading = true);

                    try {
                      // 第一步：验证 oobCode
                      await FirebaseAuth.instance
                          .verifyPasswordResetCode(code);
                      // 第二步：确认并重置到新密码
                      await FirebaseAuth.instance.confirmPasswordReset(
                        code: code,
                        newPassword: _newPassword,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Password reset successfully'),
                          backgroundColor: kPrimaryColor,
                        ),
                      );
                      Navigator.pushReplacementNamed(
                        context,
                        SignInScreen.routeName,
                      );
                    } on FirebaseAuthException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Reset failed: ${e.message ?? 'Unknown error'}'),
                        ),
                      );
                    } finally {
                      setState(() => _loading = false);
                    }
                  },
                  child: _loading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation(Colors.white),
                        )
                      : const Text('Confirm'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../complete_profile/complete_profile_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? confirmPassword;
  bool remember = false;
  bool isLoading = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }


  Future<void> _register() async {
    if (!_formKey.currentState!.validate())
    {
      print(">>> validate failed");
      return;
    };
    _formKey.currentState!.save();
    print('>>> values: $email / $password');

    setState(() {
      isLoading = true;
    });
    try {
      UserCredential cred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email!.trim(),
            password: password!.trim(),
          );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(cred.user!.uid)
          .set({
        'email': email!.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      print('>>> firestore write done');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
        Navigator.pushNamed(context, CompleteProfileScreen.routeName);
      }
    } on FirebaseAuthException catch (e) {
      print('❌ FirebaseAuthException: code=${e.code}, message=${e.message}');
      String message = 'Registration failed, please try again';
      if (e.code == 'email-already-in-use') {
        message = 'This email address has been registered';
      } else if (e.code == 'invalid-email') {
        message = 'The email format is incorrect';
      } else if (e.code == 'weak-password') {
        message = 'The password is not strong enough (at least 8 characters)';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e, st) {
      // 其他错误
      print('❌ Unexpected error: $e\n$st');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('error: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          //Email
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kEmailNullError);
              }
              if (emailValidatorRegExp.hasMatch(value)) {
                removeError(error: kInvalidEmailError);
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                addError(error: kEmailNullError);
                return "";
              }
              if (!emailValidatorRegExp.hasMatch(value)) {
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
          // Password
          TextFormField(
            obscureText: true,
            onSaved: (newValue) => password = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              }
              if (value.length >= 8) {
                removeError(error: kShortPassError);
              }
              password = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                addError(error: kPassNullError);
                return "";
              }
              if (value.length < 8) {
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
          //Confirm Password
          TextFormField(
            obscureText: true,
            onSaved: (newValue) => confirmPassword = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              }
              if (value.isNotEmpty && password == value) {
                removeError(error: kMatchPassError);
              }
              confirmPassword = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                addError(error: kPassNullError);
                return "";
              }
              if (password != value) {
                addError(error: kMatchPassError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Confirm Password",
              hintText: "Re-enter your password",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          const SizedBox(height: 10),
          FormError(errors: errors),
          const SizedBox(height: 20),
          //button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: isLoading ? null : _register,
              child: isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                  : const Text("Continue"),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../sign_in/sign_in_screen.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({super.key});

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  bool isLoading = false;

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

  /// 校验、保存表单并写入 Firestore，然后导航
  Future<void> _completeProfile() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => isLoading = true);
    try {
      // 当前已登录用户
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw '未检测到登录用户';
      }

      // 更新 Firestore 中 users/{uid}
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({
            'firstName': firstName!.trim(),
            'lastName': lastName?.trim() ?? '',
            'phoneNumber': phoneNumber!.trim(),
            'address': address!.trim(),
            'profileCompleted': true,
            'updatedAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));

      // 提示并跳转到登录
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign up successful, please log in')),
        );
        Navigator.pushNamed(context, SignInScreen.routeName);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('fail to store profile：$e')),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // First Name
          TextFormField(
            onSaved: (v) => firstName = v,
            onChanged: (v) {
              if (v.isNotEmpty) removeError(error: kNamelNullError);
            },
            validator: (v) {
              if (v == null || v.isEmpty) {
                addError(error: kNamelNullError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "First Name",
              hintText: "Enter your first name",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
            ),
          ),
          const SizedBox(height: 20),

          // Last Name
          TextFormField(
            onSaved: (v) => lastName = v,
            decoration: const InputDecoration(
              labelText: "Last Name",
              hintText: "Enter your last name",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
            ),
          ),
          const SizedBox(height: 20),

          // Phone Number
          TextFormField(
            keyboardType: TextInputType.phone,
            onSaved: (v) => phoneNumber = v,
            onChanged: (v) {
              if (v.isNotEmpty) removeError(error: kPhoneNumberNullError);
            },
            validator: (v) {
              if (v == null || v.isEmpty) {
                addError(error: kPhoneNumberNullError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Phone Number",
              hintText: "Enter your phone number",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
            ),
          ),
          const SizedBox(height: 20),

          // Address
          TextFormField(
            onSaved: (v) => address = v,
            onChanged: (v) {
              if (v.isNotEmpty) removeError(error: kAddressNullError);
            },
            validator: (v) {
              if (v == null || v.isEmpty) {
                addError(error: kAddressNullError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Address",
              hintText: "Enter your address",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon:
                  CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
            ),
          ),
          const SizedBox(height: 10),

          FormError(errors: errors),
          const SizedBox(height: 20),

          // Continue 按钮
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: isLoading ? null : _completeProfile,
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

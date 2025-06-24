import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
class MyAccountScreen extends StatefulWidget {
  static String routeName = "/my_account";
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? _userData;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await _firestore.collection('users').doc(uid).get();
    setState(() {
      _userData = doc.data()!;
      _loading = false;
    });
  }

  Future<void> _updateField(String field, dynamic newValue) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await _firestore
        .collection('users')
        .doc(uid)
        .update({field: newValue, 'updatedAt': FieldValue.serverTimestamp()});
    setState(() => _userData![field] = newValue);
  }

  // Generic text‐edit dialog
  Future<void> _editTextField(String field, String label) async {
    final controller = TextEditingController(text: _userData![field]?.toString() ?? '');
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit $label'),
        content: TextFormField(
          controller: controller,
          decoration: InputDecoration(hintText: label),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final val = controller.text.trim();
              if (val.isNotEmpty) {
                _updateField(field, val);
              }
              Navigator.of(context).pop();
            },
            child: const Text('Confirm',
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

  // Gender picker dialog
  Future<void> _editGender() async {
    final options = ['Male', 'Female', 'Other'];
    String? selection = _userData!['gender'];
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Select Gender'),
        content: DropdownButtonFormField<String>(
          value: selection,
          items: options
              .map((g) => DropdownMenuItem(value: g, child: Text(g)))
              .toList(),
          onChanged: (v) => selection = v,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (selection != null) _updateField('gender', selection);
              Navigator.of(context).pop();
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  // Birthday picker
  Future<void> _editBirthday() async {
    DateTime? initial = DateTime.tryParse(_userData!['birthday'] ?? '');
    initial ??= DateTime(2000);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      final formatted = DateFormat('yyyy-MM-dd').format(picked);
      await _updateField('birthday', formatted);
    }
  }

  // Phone picker dialog (you may swap in a country picker here)
  Future<void> _editPhone() async {
    final controller = TextEditingController(text: _userData!['phoneNumber'] ?? '');
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Phone Number'),
        content: TextFormField(
          controller: controller,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(hintText: 'e.g. +60 12-3456789'),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final val = controller.text.trim();
              if (val.isNotEmpty) _updateField('phoneNumber', val);
              Navigator.of(context).pop();
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFB9B6D), Color(0xFFF76B1C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(32),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    AssetImage("assets/images/Profile Image.png"),
              ),
            ),
            const SizedBox(height: 20),

            // First Name
            _buildInfoTile(
              Icons.person,
              "Name",
              _userData!['firstName'] ?? '',
              () => _editTextField('firstName', 'Name'),
            ),

            // Gender
            _buildInfoTile(
              Icons.male,
              "Gender",
              _userData!['gender'] ?? '',
              _editGender,
            ),

            // Birthday
            _buildInfoTile(
              Icons.cake,
              "Birthday",
              _userData!['birthday'] ?? '',
              _editBirthday,
            ),

            // Shipping Address
            _buildInfoTile(
              Icons.location_on,
              "Shipping Address",
              _userData!['address'] ?? '',
              () => _editTextField('address', 'Shipping Address'),
            ),

            // Postal Code
            _buildInfoTile(
              Icons.local_post_office,
              "Postal Code",
              _userData!['postalCode'] ?? '',
              () => _editTextField('postalCode', 'Postal Code'),
            ),

            // Contact Number
            _buildInfoTile(
              Icons.phone,
              "Contact Number",
              _userData!['phoneNumber'] ?? '',
              _editPhone,
            ),

            // Email (read-only)
            _buildInfoTile(
              Icons.email,
              "Email Address",
              _userData!['email'] ?? '',
              null, // no edit
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(
    IconData icon,
    String title,
    String value,
    VoidCallback? onTap,
  ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.orange.shade100,
          child: Icon(icon, color: Colors.orange),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value.isNotEmpty ? value : "Tap to set"),
        trailing: onTap != null ? const Icon(Icons.edit) : null,
        onTap: onTap,
      ),
    );
  }
}

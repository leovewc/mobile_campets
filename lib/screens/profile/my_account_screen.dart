import 'package:flutter/material.dart';

class MyAccountScreen extends StatelessWidget {
  static String routeName = "/my_account";

  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Account"),
        backgroundColor: Color(0xFFFF7643),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/Profile Image.png"),
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoTile(Icons.person, "Name", "Alex Tan"),
            _buildInfoTile(Icons.male, "Gender", "Male"),
            _buildInfoTile(Icons.cake, "Birthday", "1995-08-14"),
            _buildInfoTile(Icons.location_on, "Shipping Address", "123, Jalan Damai, Kuala Lumpur"),
            _buildInfoTile(Icons.local_post_office, "Postal Code", "50400"),
            _buildInfoTile(Icons.phone, "Contact Number", "+60 12-345 6789"),
            _buildInfoTile(Icons.email, "Email Address", "alex.tan@example.com"),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
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
        subtitle: Text(value),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  static String routeName = "/notifications";

  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Color(0xFFFF7643),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          NotificationCard(
            title: "Price Drop Alert!",
            message: "The price of the items you have saved has been reduced!",
            time: "Just now",
            icon: Icons.local_offer,
          ),
          NotificationCard(
            title: "New Arrivals",
            message: "New cat products are now available!",
            time: "10 min ago",
            icon: Icons.pets,
          ),
          NotificationCard(
            title: "Profile Reminder",
            message: "Please complete your personal information as soon as possible.",
            time: "1 hour ago",
            icon: Icons.person_outline,
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final IconData icon;

  const NotificationCard({
    super.key,
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.orange.shade100,
          child: Icon(icon, color: Colors.orange),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            const SizedBox(height: 4),
            Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}

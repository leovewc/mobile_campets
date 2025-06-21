import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  static String routeName = "/help_center";

  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help Center"),
        backgroundColor: Color(0xFFFF7643),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Popular Questions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildCategoryChip("The issue of state subsidies"),
                _buildCategoryChip("Platform event"),
                _buildCategoryChip("After-sales"),
                _buildCategoryChip("Problem"),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              "Common Questions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Divider(),
            ...[
              "What should I do if the goods received have any defects?",
              "Request for invoice",
              "A return request",
              "Why would it show as delivered if no goods were received?",
              "Inquire about the logistics status",
              "Inquire about the return policy",
              "Inquire about the status of return and exchange",
            ].map((q) => Column(
              children: [
                ListTile(
                  title: Text(q),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {}, // Placeholder for future routing
                ),
                const Divider(),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.w500),
      ),
    );
  }
}

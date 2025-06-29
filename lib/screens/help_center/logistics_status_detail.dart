import 'package:flutter/material.dart';

class LogisticsStatusDetailScreen extends StatefulWidget {
  static String routeName = "/logistics_status_detail";
  const LogisticsStatusDetailScreen({Key? key}) : super(key: key);

  @override
  State<LogisticsStatusDetailScreen> createState() => _LogisticsStatusDetailScreenState();
}

class _LogisticsStatusDetailScreenState extends State<LogisticsStatusDetailScreen> {
  String? selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' '),
        toolbarHeight: 44,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8.0, left: 28.0, right: 28.0, bottom: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How to Check the Status of Your Shipment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.7),
            ),
            SizedBox(height: 12),
            const Text(
              '1. Track Your Order\n'
              'Use the tracking information provided in your order details to monitor the status of your shipment.\n\n'
              '2. Delayed Updates\n'
              'If the tracking information is not updated for more than 48 hours, please contact our customer service for assistance.\n\n'
              '3. Possible Delays\n'
              'Delays may occur due to weather, customs, or other unforeseen circumstances. We appreciate your understanding and patience.\n\n'
              '4. Customer Support\n'
              'Our team will coordinate with the logistics provider and keep you informed until your package is delivered.',
              style: TextStyle(fontSize: 16, height: 1.7, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 32),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 24,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      selected = 'solved';
                    });
                  },
                  icon: Icon(Icons.thumb_up, color: selected == 'solved' ? Colors.white : Colors.green),
                  label: const Text('Solved'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selected == 'solved' ? Colors.green : Colors.white,
                    foregroundColor: selected == 'solved' ? Colors.white : Colors.green,
                    side: const BorderSide(color: Colors.green),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      selected = 'unsolved';
                    });
                  },
                  icon: Icon(Icons.thumb_down, color: selected == 'unsolved' ? Colors.white : Colors.red),
                  label: const Text('Unsolved'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selected == 'unsolved' ? Colors.red : Colors.white,
                    foregroundColor: selected == 'unsolved' ? Colors.white : Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 
import 'package:flutter/material.dart';

class ReturnRequestDetailScreen extends StatefulWidget {
  static String routeName = "/return_request_detail";
  const ReturnRequestDetailScreen({Key? key}) : super(key: key);

  @override
  State<ReturnRequestDetailScreen> createState() => _ReturnRequestDetailScreenState();
}

class _ReturnRequestDetailScreenState extends State<ReturnRequestDetailScreen> {
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
              'How to Submit a Return Request',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.7),
            ),
            SizedBox(height: 12),
            const Text(
              '1. Eligibility Check\n'
              'Returns are accepted within 7 days of receiving the product, provided the item is unused and in its original packaging.\n\n'
              '2. Submit the Request\n'
              'Fill out the return form in your order details. Attach clear photos and a detailed description of the issue to help us process your request efficiently.\n\n'
              '3. Review and Approval\n'
              'Our support team will review your request and contact you for further steps. Once approved, you will receive instructions for shipping the item back.\n\n'
              '4. Refund or Exchange\n'
              'Refunds or exchanges will be processed after we receive and inspect the returned product. We strive to complete this process as quickly as possible.',
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
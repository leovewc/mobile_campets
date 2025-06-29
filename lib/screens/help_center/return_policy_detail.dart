import 'package:flutter/material.dart';

class ReturnPolicyDetailScreen extends StatefulWidget {
  static String routeName = "/return_policy_detail";
  const ReturnPolicyDetailScreen({Key? key}) : super(key: key);

  @override
  State<ReturnPolicyDetailScreen> createState() => _ReturnPolicyDetailScreenState();
}

class _ReturnPolicyDetailScreenState extends State<ReturnPolicyDetailScreen> {
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
              'Return Policy Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.7),
            ),
            SizedBox(height: 12),
            const Text(
              '1. Return Period\n'
              'You may return products within 7 days of receipt, provided they are unused and in their original packaging.\n\n'
              '2. How to Initiate a Return\n'
              'Submit a return request through your order details page. Our team will review your request and provide further instructions.\n\n'
              '3. Refund Process\n'
              'Refunds will be processed after the returned item is received and inspected. Please allow a few working days for the refund to appear in your account.\n\n'
              '4. Further Assistance\n'
              'For more details, please refer to our full return policy or contact our support team for personalized help.',
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
import 'package:flutter/material.dart';

class RequestInvoiceDetailScreen extends StatefulWidget {
  static String routeName = "/request_invoice_detail";
  const RequestInvoiceDetailScreen({Key? key}) : super(key: key);

  @override
  State<RequestInvoiceDetailScreen> createState() => _RequestInvoiceDetailScreenState();
}

class _RequestInvoiceDetailScreenState extends State<RequestInvoiceDetailScreen> {
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
              'How to Request an Official Invoice',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.7),
            ),
            SizedBox(height: 12),
            const Text(
              '1. Order Details Page\n'
              'Go to your order details page and click on the "Request Invoice" button.\n\n'
              '2. Provide Accurate Information\n'
              'Ensure your billing information is complete and accurate. If you need a special format or additional details, please specify them in the remarks section.\n\n'
              '3. Processing Time\n'
              'Our team will process your invoice request within 3 working days. For urgent needs, you may contact customer service directly.\n\n'
              '4. Receiving Your Invoice\n'
              'If you do not receive your invoice after 3 working days, please check your spam folder or contact us for further assistance.',
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
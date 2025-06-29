import 'package:flutter/material.dart';

class QuestionDefectDetailScreen extends StatefulWidget {
  static String routeName = "/question_defect_detail";
  const QuestionDefectDetailScreen({Key? key}) : super(key: key);

  @override
  State<QuestionDefectDetailScreen> createState() => _QuestionDefectDetailScreenState();
}

class _QuestionDefectDetailScreenState extends State<QuestionDefectDetailScreen> {
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
              'How to Handle Defective Goods',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.7),
            ),
            SizedBox(height: 12),
            const Text(
              '1. Immediate Action\n'
              'Upon receiving your goods, please inspect them carefully. If you notice any defects, do not use the product and keep all original packaging.\n\n'
              '2. Contact Customer Service\n'
              'Within 24 hours, contact our customer service team. Please provide your order number, a detailed description of the defect, and clear photos showing the issue.\n\n'
              '3. Review and Response\n'
              'Our team will review your case as soon as possible. We may request additional information or photos to better understand the problem.\n\n'
              '4. Return or Exchange Process\n'
              'If the defect is confirmed, we will guide you through the return or exchange process. We are committed to ensuring a smooth and satisfactory after-sales experience for you.',
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
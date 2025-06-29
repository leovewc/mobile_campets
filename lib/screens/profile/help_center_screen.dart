import 'package:flutter/material.dart';
import '../help_center/question_defect_detail.dart';
import '../help_center/request_invoice_detail.dart';
import '../help_center/return_request_detail.dart';
import '../help_center/delivered_no_goods_detail.dart';
import '../help_center/logistics_status_detail.dart';
import '../help_center/return_policy_detail.dart';
import '../help_center/return_exchange_status_detail.dart';

class HelpCenterScreen extends StatelessWidget {
  static String routeName = "/help_center";

  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Help Center",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
        ),
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
        iconTheme: const IconThemeData(color: Colors.white),
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
                  onTap: () {
                    if (q == "What should I do if the goods received have any defects?") {
                      Navigator.pushNamed(context, QuestionDefectDetailScreen.routeName);
                    } else if (q == "Request for invoice") {
                      Navigator.pushNamed(context, RequestInvoiceDetailScreen.routeName);
                    } else if (q == "A return request") {
                      Navigator.pushNamed(context, ReturnRequestDetailScreen.routeName);
                    } else if (q == "Why would it show as delivered if no goods were received?") {
                      Navigator.pushNamed(context, DeliveredNoGoodsDetailScreen.routeName);
                    } else if (q == "Inquire about the logistics status") {
                      Navigator.pushNamed(context, LogisticsStatusDetailScreen.routeName);
                    } else if (q == "Inquire about the return policy") {
                      Navigator.pushNamed(context, ReturnPolicyDetailScreen.routeName);
                    } else if (q == "Inquire about the status of return and exchange") {
                      Navigator.pushNamed(context, ReturnExchangeStatusDetailScreen.routeName);
                    }
                  },
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



import 'package:url_launcher/url_launcher.dart';

/// 跳转到 Stripe 托管结账页面（测试模式链接）
Future<void> launchTestCheckout() async {
  final url = Uri.parse('https://buy.stripe.com/test_14A14p0EAeO432k5ii2sM00');
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}

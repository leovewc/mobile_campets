import 'package:flutter/material.dart';
import 'package:campets/constants.dart';
import '../../components/showConfirmationDialog.dart';
class PaymentOptionPage extends StatefulWidget {
  static const String routeName = '/payment';
  const PaymentOptionPage({super.key});

  @override
  State<PaymentOptionPage> createState() => _PaymentOptionPageState();
}

class _PaymentOptionPageState extends State<PaymentOptionPage> {
  static const String routeName = '/payment';
  int? _selectedIndex;

  // ── Palette
  static const Color _bg = Color(0xFFF9F9FB);
  static const Color _primary = Color(0xFF4F46E5); // indigo-600
  static const Color _primaryAlt = Color(0xFF1E3A8A); // indigo-900
  static const Color _cardBorder = Color(0xFFE5E7EB); // gray-200


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text('Payment Option',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── My Card header + add button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('My Card',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddCardPage()),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AnimatedPadding(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.only(bottom: _selectedIndex != null ? 24 : 0),
              child: const _CreditCardWidget(),
            ),
            const Text('Other Payment Option',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            InkWell(
              onTap: () => setState(() => _selectedIndex = 0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: _selectedIndex == 0
                      ? [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))]
                      : [],
                ),
                child: _PaymentOptionTile(
                  assetPath: 'assets/icons/paypal.png',
                  title: 'Paypal',
                  subtitle: 'mypaypal@gmail.com',
                ),
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
                onTap: () => setState(() => _selectedIndex = 1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: _selectedIndex == 0
                        ? [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))]
                        : [],
                  ),
              child: _PaymentOptionTile(
                iconData: Icons.money,
                title: 'Cash on Delivery',
                subtitle: 'Pay in Cash',
              ),
            ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () => setState(() => _selectedIndex = 2),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: _selectedIndex == 0
                        ? [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))]
                        : [],
                  ),
              child: _PaymentOptionTile(
                assetPath: 'assets/icons/apple.png',
                title: 'Apple Pay',
                subtitle: 'applepay.com',
              ),
            ),
            ),
            const SizedBox(height: 32),
            if (_selectedIndex != null) ...[
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    showConfirmationDialog(
                      context,
                      'Payment Successful',
                      'Your payment has been processed successfully.',
                          () {
                        // 例如：Navigator.pop(context);
                      },
                    );
                  },
                  child: const Text('Confirm Payment', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Helper Widgets
// ─────────────────────────────────────────────────────────────────────────────

class _CreditCardWidget extends StatelessWidget {
  const _CreditCardWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('1464 *** 5456',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('VALID\nTHRU',
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          height: 1.2,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 2),
                  Text('10/24',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text('Dannis Alvert',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 4),
                  Text('VISA',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PaymentOptionTile extends StatelessWidget {
  /// Optionally provide either an [iconData] or an [assetPath] for the leading
  /// graphic. At least one must be non-null.
  final IconData? iconData;
  final String? assetPath;
  final String title;
  final String subtitle;

  const _PaymentOptionTile({
    this.iconData,
    this.assetPath,
    required this.title,
    required this.subtitle,
  }) : assert(iconData != null || assetPath != null,
  'iconData or assetPath must be provided');

  @override
  Widget build(BuildContext context) {
    Widget leading;
    if (assetPath != null) {
      leading = Image.asset(assetPath!, width: 28, height: 28, fit: BoxFit.contain);
    } else {
      leading = Icon(iconData, size: 28, color: _PaymentOptionPageState._primaryAlt);
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _PaymentOptionPageState._cardBorder),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _PaymentOptionPageState._cardBorder.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: leading,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _numberCtrl = TextEditingController();
  final _expiryCtrl = TextEditingController();
  final _cvvCtrl = TextEditingController();
  bool _remember = false;
  late final List<TextEditingController> _controllers;
  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose(); // ★ 释放所有绑定了监听的控制器
    }
    _cvvCtrl.dispose(); // ★ CVV 不监听，单独释放
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controllers = [_nameCtrl, _numberCtrl, _expiryCtrl];
    for (final c in _controllers) {
      c.addListener(() => setState(() {}));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text('Add New Card',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ★ 新增: 顶部实时预览
            _DynamicCardPreview(
              cardNumber: _numberCtrl.text,
              expiry: _expiryCtrl.text,
              name: _nameCtrl.text,
            ), // ★
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildField(
                    label: 'Card Number',
                    controller: _numberCtrl,
                    keyboardType: TextInputType.number,
                    maxLength: 19,
                  ),
                  const SizedBox(height: 16),
                  _buildField(
                      label: 'Card Name',
                      controller: _nameCtrl
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildField(
                            label: 'Expire Date',
                            controller: _expiryCtrl,
                            keyboardType: TextInputType.datetime,
                            hint: 'MM/YY',
                            maxLength: 5,
                            onChanged: (_) => setState(() {})),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildField(
                            label: 'CVV',
                            controller: _cvvCtrl,
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            obscureText: true),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Remember My Card Details',
                          style: TextStyle(fontSize: 15)),
                      Switch(
                        value: _remember,
                        activeColor: kPrimaryColor,
                        onChanged: (v) => setState(() => _remember = v),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Card Added (mock).')),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Add Card',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ★ 新增: 通用文本字段构造
  Widget _buildField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    String? hint,
    int? maxLength,
    bool obscureText = false,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      obscureText: obscureText,
      decoration: InputDecoration(
        counterText: '',
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
      onChanged: onChanged,
    );
  }
}

// ★ 新增: 实时卡片预览组件
class _DynamicCardPreview extends StatelessWidget {
  final String cardNumber;
  final String expiry;
  final String name;
  const _DynamicCardPreview({
    required this.cardNumber,
    required this.expiry,
    required this.name,
  });

  String get _prettyNumber {
    final digits = cardNumber.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return 'XXXX XXXX XXXX XXXX';
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);
      if ((i + 1) % 4 == 0 && i != digits.length - 1) buffer.write(' ');
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [Color(0xFFB92B27), Color(0xFF1565C0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text(_prettyNumber,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                letterSpacing: 2,
                fontWeight: FontWeight.w600)),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                  const Text('VALID THRU',
                    style: TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                    height: 1.2,
                    fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text(expiry.isEmpty ? 'MM/YY' : expiry,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
                  ],
             ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(name.isEmpty ? 'CARD HOLDER' : name.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        const Text('VISA',
          style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          letterSpacing: 2,
          fontWeight: FontWeight.w700)),
      ],
    ),
    ],
    ),
    ],
    ),
    );
  }
}
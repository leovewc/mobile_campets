import 'package:flutter/material.dart';
import 'package:campets/constants.dart';
import '../../components/showConfirmationDialog.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:url_launcher/url_launcher.dart';
import 'service/checkout_service.dart';
import 'components/pick_payment.dart';
import 'components/pick_card.dart';

class PaymentOptionPage extends StatefulWidget {
  static const String routeName = '/payment';
  const PaymentOptionPage({super.key});

  @override
  State<PaymentOptionPage> createState() => _PaymentOptionPageState();
}

class _PaymentOptionPageState extends State<PaymentOptionPage> {
  int _selectedCardIndex = 0;
  int? _selectedOptionIndex;
  final _pageController = PageController(viewportFraction: 0.9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Payment Option',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: Column(
        children: [
          // My Card
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Card',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
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
          ),

          const SizedBox(height: 16),

          // 卡片
          CardListWidget(
            controller: _pageController,
            selectedIndex: _selectedCardIndex,
            onCardSelected: (int i) {
              if (i == _selectedCardIndex) return;        
              setState(() {
                _selectedCardIndex = i;
                _selectedOptionIndex = null;
              });
              _pageController.animateToPage(
                i,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
          ),
          const SizedBox(height: 24),

          //其他支付方式 
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView(
                children: [
                  const Text(
                    'Other Payment Option',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 16),

                  // 使用新的增强支付选项组件
                  EnhancedPaymentOptionTile(
                    index: 0,
                    selectedIndex: _selectedOptionIndex,
                    assetPath: 'assets/icons/paypal.png',
                    title: 'Paypal',
                    subtitle: 'paypal.com',
                    onTap: () {
                      setState(() {
                        _selectedOptionIndex = 0;
                        _selectedCardIndex = -1;
                      });
                    },
                  ),
                  
                  EnhancedPaymentOptionTile(
                    index: 1,
                    selectedIndex: _selectedOptionIndex,
                    iconData: Icons.money,
                    title: 'Cash on Delivery',
                    subtitle: 'Pay in Cash',
                    onTap: () {
                      setState(() {
                        _selectedOptionIndex = 1;
                        _selectedCardIndex = -1;
                      });
                    },
                  ),
                  
                  EnhancedPaymentOptionTile(
                    index: 2,
                    selectedIndex: _selectedOptionIndex,
                    assetPath: 'assets/icons/apple.png',
                    title: 'Apple Pay',
                    subtitle: 'applepay.com',
                    onTap: () {
                      setState(() {
                        _selectedOptionIndex = 2;
                        _selectedCardIndex = -1;
                      });
                    },
                  ),
                  const SizedBox(height: 32),
                  if (_selectedCardIndex != null || _selectedOptionIndex != null)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                         onPressed: launchTestCheckout,
                        

                    
                        child: const Text(
                          'Confirm Payment',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 分离的“其他支付方式”选中逻辑
  Widget _buildOptionTile({required int index, required Widget child}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          setState(() {
            _selectedOptionIndex = index;
            // 可选：同时取消卡片选中
            _selectedCardIndex = -1;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: _selectedOptionIndex == index
                ? [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))]
                : [],
          ),
          child: child,
        ),
      ),
    );
  }


  Widget _buildCardContainer({
    required String cardNumber,
    required String expiry,
    required String holder,
    required bool selected,
  }) {
    // 卡片主体，**不带 margin**
    final inner = Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: _buildCardContent(cardNumber, expiry, holder),
    );

    // 包裹选中态的流光边框或普通状态，再统一加上 margin
    Widget card = selected
        ? ShinyBorderCard(radius: 12, borderWidth: 3, child: inner)
        : inner;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: card,
    );
  }

  Widget _buildCardContent(String no, String exp, String holder) {
    final masked = no.replaceAllMapped(RegExp(r".{4}"), (m) => "${m.group(0)} ").trim();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(masked, style: const TextStyle(color: Colors.white, fontSize: 22, letterSpacing: 2, fontWeight: FontWeight.w600)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('VALID THRU', style: TextStyle(color: Colors.white70, fontSize: 10, height: 1.2, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(exp, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(holder.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                const Text('VISA', style: TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 2, fontWeight: FontWeight.w700)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// Helper Widgets

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
      leading = Icon(iconData, size: 28, color: primaryAlt);
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorder),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: cardBorder.withOpacity(0.3),
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
  void initState() {
    super.initState();
    _controllers = [_nameCtrl, _numberCtrl, _expiryCtrl];
    for (final c in _controllers) {
      c.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    _cvvCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Card',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _numberCtrl,
                decoration: const InputDecoration(labelText: 'Card Number'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Card Holder'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _expiryCtrl,
                      decoration: const InputDecoration(labelText: 'Expiry (MM/YY)'),
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _cvvCtrl,
                      decoration: const InputDecoration(labelText: 'CVV'),
                      obscureText: true,
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Remember My Card'),
                  Switch(
                    value: _remember,
                    onChanged: (v) => setState(() => _remember = v),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        final uid = user.uid;
                        // 构造要保存的数据
                        final cardData = {
                          'cardNumber': _numberCtrl.text.trim(),
                          'cardHolder': _nameCtrl.text.trim(),
                          'expiry': _expiryCtrl.text.trim(),
                          'remember': _remember,
                          'timestamp': FieldValue.serverTimestamp(),
                        };
                        
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid)
                            .collection('paymentCards')
                            .add(cardData);

                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Card saved')),
                        );
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Save failed: $e')),
                      );
                    }
                  }
                },
                child: const Text('Add Card'),
              ),
            ],
          ),
        ),
      ),
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

//选中效果
class GlowingBorder extends StatefulWidget {
  final Widget child;

  const GlowingBorder({super.key, required this.child});

  @override
  _GlowingBorderState createState() => _GlowingBorderState();
}

class _GlowingBorderState extends State<GlowingBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // 无限循环
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 3,
              color: Colors.transparent,
            ),
          ),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [Colors.purpleAccent, Colors.blueAccent, Colors.cyan],
                stops: [0.0, 0.5, 1.0],
                begin: Alignment(-1.0 + 2.0 * _controller.value, 0),
                end: Alignment(1.0 + 2.0 * _controller.value, 0),
                tileMode: TileMode.mirror,
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: widget.child,
          ),
        );
      },
    );
  }
}



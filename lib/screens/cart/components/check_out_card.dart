import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../checkout/payment.dart';
import 'dart:async'; 


class CheckoutCard extends StatefulWidget {
  const CheckoutCard({Key? key}) : super(key: key);

  @override
  _CheckoutCardState createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  double _total = 0.0;
  bool _isLoading = true;
  late StreamSubscription<QuerySnapshot> _cartSubscription;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _setupCartListener();
  }

  void _setupCartListener() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      setState(() {
        _isLoading = false;
        _total = 0.0;
      });
      return;
    }

    final cartRef = _firestore
        .collection('users')
        .doc(uid)
        .collection('cart');

    _cartSubscription = cartRef.snapshots().listen((cartSnapshot) {
      if (cartSnapshot.docs.isEmpty) {
        setState(() {
          _total = 0.0;
          _isLoading = false;
        });
        return;
      }
      
      _calculateTotal(cartSnapshot.docs);
    }, onError: (error) {
      print('Error listening to cart: $error');
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _calculateTotal(List<QueryDocumentSnapshot> docs) async {
    try {
      double calculatedTotal = 0.0;
      
      for (final doc in docs) {
        final productId = doc.id;
        final quantity = doc.get('quantity') as int;
        
        final productSnapshot = await _firestore
            .collection('products')
            .doc(productId)
            .get();
            
        if (productSnapshot.exists) {
          final price = (productSnapshot.data()!['price'] as num).toDouble();
          calculatedTotal += price * quantity;
        }
      }
      
      setState(() {
        _total = calculatedTotal;
        _isLoading = false;
      });
    } catch (e) {
      print('Error calculating total: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _cartSubscription.cancel(); // 取消订阅
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: _buildContent(),
    );
  }
  
  Widget _buildContent() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _isLoading
          ? _buildLoadingUI()
          : _buildCheckoutUI(),
    );
  }
  
  Widget _buildLoadingUI() {
    return const Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 16),
          Text("Calculating total..."),
        ],
      ),
    );
  }
  
  Widget _buildCheckoutUI() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth * 0.6,
              ),
              child: Text(
                'Total: \$${_total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            ElevatedButton(
              onPressed: _total > 0 ? () {
                Navigator.pushNamed(context, PaymentOptionPage.routeName);
              } : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                minimumSize: const Size(0, 48),
              ),
              child: const Text('Check Out'),
            ),
          ],
        );
      }
    );
  }
}
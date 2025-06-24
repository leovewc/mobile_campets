import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/Product.dart';
import 'components/cart_card.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart');

    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: StreamBuilder<QuerySnapshot>(
        stream: cartRef.snapshots(),
        builder: (ctx, cartSnap) {
          if (cartSnap.connectionState != ConnectionState.active) {
            return const Center(child: CircularProgressIndicator());
          }
          
          // 处理空购物车状态
          if (!cartSnap.hasData || cartSnap.data!.docs.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Your cart is empty\nStart shopping to add items!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            );
          }
          
          final docs = cartSnap.data!.docs;
          
          return Column(
            children: [
              // 1. 列表区 - 确保使用Expanded提供约束
              Expanded(
                child: ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final productId = doc.id;
                    final quantity = doc.get('quantity') as int;

                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('products')
                          .doc(productId)
                          .get(),
                      builder: (ctxProd, prodSnap) {
                        // 始终返回一个有明确尺寸的组件
                        if (prodSnap.connectionState != ConnectionState.done) {
                          return _buildLoadingItem();
                        }
                        
                        if (!prodSnap.hasData || !prodSnap.data!.exists) {
                          return _buildUnavailableItem(
                            productId: productId,
                            cartRef: cartRef,
                          );
                        }
                        
                        final map = prodSnap.data!.data()! as Map<String, dynamic>;
                        final product = Product.fromMap(map);

                        return CartCard(
                          product: product,
                          quantity: quantity,
                          onRemove: () => cartRef.doc(productId).delete(),
                          onQuantityChanged: (newQty) => 
                              cartRef.doc(productId).update({'quantity': newQty}),
                        );
                      },
                    );
                  },
                ),
              ),

              // 2. 底部结算栏 - 确保它总是有尺寸
              const SafeArea(
                child: CheckoutCard(),
              ),
            ],
          );
        },
      ),
    );
  }
  
  // 加载中商品项的UI
  Widget _buildLoadingItem() {
    return const Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        height: 120,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
  
  // 不可用商品项的UI
  Widget _buildUnavailableItem({
    required String productId,
    required CollectionReference cartRef,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 32),
            const SizedBox(width: 16),
            const Expanded(
              child: Text(
                'Product unavailable',
                style: TextStyle(fontSize: 16),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => cartRef.doc(productId).delete(),
            ),
          ],
        ),
      ),
    );
  }
}
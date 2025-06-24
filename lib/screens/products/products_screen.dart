// lib/screens/products/products_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:campets/components/product_card.dart';
import 'package:campets/models/Product.dart';
import '../details/details_screen.dart';

class ProductsScreen extends StatelessWidget {
  static const String routeName = "/products";
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    String? query;
    String? category;
    if (args is String) {
      query = args;
    } else if (args is Map<String, dynamic>) {
      query = args['query'] as String?;
      category = args['category'] as String?;
    }

    final uid = FirebaseAuth.instance.currentUser!.uid;
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(uid);
    final prodStream =
        FirebaseFirestore.instance.collection('products').snapshots();

    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: StreamBuilder<DocumentSnapshot>(
        stream: userRef.snapshots(),
        builder: (ctxUser, userSnap) {
          if (userSnap.connectionState != ConnectionState.active) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!userSnap.hasData || !userSnap.data!.exists) {
            return const Center(child: Text("User data not found."));
          }

          final userData = userSnap.data!.data()! as Map<String, dynamic>;
          final favList = List<String>.from(
            (userData['favorites'] as List<dynamic>?) ?? [],
          );

          return StreamBuilder<QuerySnapshot>(
            stream: prodStream,
            builder: (ctxProd, prodSnap) {
              if (prodSnap.connectionState != ConnectionState.active) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!prodSnap.hasData || prodSnap.data!.docs.isEmpty) {
                return const Center(child: Text("No products found."));
              }

              List<Product> products = prodSnap.data!.docs.map((doc) {
                final map = doc.data()! as Map<String, dynamic>;
                final p = Product.fromMap(map);
                final isFav = favList.contains(p.id.toString());
                return p.copyWith(isFavourite: isFav);
              }).toList();

              if (query != null && query.isNotEmpty) {
                final q = query.toLowerCase();
                products = products
                    .where((p) => p.title.toLowerCase().contains(q))
                    .toList();
              } else if (category != null && category.isNotEmpty) {
                final c = category.toLowerCase();
                products = products
                    .where((p) => p.category.toLowerCase() == c)
                    .toList();
              }

              if (products.isEmpty) {
                final term = query ?? category ?? "";
                return Center(child: Text('No results for "$term"'));
              }
 
              return Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate:
                      const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (_, index) {
                    final product = products[index];
                    return ProductCard(
                      product: product,
                      onPress: () {
                        Navigator.pushNamed(
                          context,
                          DetailsScreen.routeName,
                          arguments: ProductDetailsArguments(
                            productId: product.id.toString(),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

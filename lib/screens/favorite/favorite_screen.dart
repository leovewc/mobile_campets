// lib/screens/favorite/favorite_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:campets/components/product_card.dart';
import 'package:campets/models/Product.dart';
import '../details/details_screen.dart';

class FavoriteScreen extends StatelessWidget {
  static const String routeName = "/favorites";
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(uid);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              "My Favorites",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF7643),
                fontFamily: 'Muli',
              ),
            ),
            Container(
              width: 480,
              height: 0.8,
              margin: const EdgeInsets.only(top: 12),
              decoration: const BoxDecoration(
                color: Color(0xFFFF7643),
                borderRadius: BorderRadius.all(Radius.circular(1)),
              ),
            ),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: userRef.snapshots(),
        builder: (ctx, userSnap) {
          if (userSnap.connectionState != ConnectionState.active) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!userSnap.hasData || !userSnap.data!.exists) {
            return const Center(child: Text("No user data."));
          }
          final data = userSnap.data!.data()! as Map<String, dynamic>;
          final favRaw = data['favorites'] as List<dynamic>? ?? [];
          final favList = List<String>.from(favRaw);

          if (favList.isEmpty) {
            return const Center(child: Text("No favorites yet."));
          }

          // Firestore whereIn 最多 10 项，若超 10 可分批请求
          return FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('products')
                .where(FieldPath.documentId, whereIn: favList)
                .get(),
            builder: (ctx2, prodSnap) {
              if (prodSnap.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              final docs = prodSnap.data!.docs;
              if (docs.isEmpty) {
                return const Center(
                    child: Text("Favorite products not found."));
              }

              final products = docs.map((d) {
                final map = d.data()! as Map<String, dynamic>;
                return Product.fromMap(map);
              }).toList();

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (ctx3, i) {
                    final p = products[i];
                    final isFav = favList.contains(p.id.toString());
                    return ProductCard(
                      product: p.copyWith(isFavourite: isFav),
                      onPress: () {
                        Navigator.pushNamed(
                          context,
                          DetailsScreen.routeName,
                          arguments: ProductDetailsArguments(
                            productId: p.id.toString(),
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

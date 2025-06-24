import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../components/product_card.dart';
import '../../../models/Product.dart';
import '../../details/details_screen.dart';
import '../../products/products_screen.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final userRef = FirebaseFirestore.instance.collection('users').doc(uid);

    // 1. 先监听当前用户的 favorites 字段
    return StreamBuilder<DocumentSnapshot>(
      stream: userRef.snapshots(),
      builder: (ctxUser, userSnap) {
        if (!userSnap.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final userData = userSnap.data!.data()! as Map<String, dynamic>;
        final favList = List<String>.from(
          userData['favorites'] as List<dynamic>? ?? [],
        );

        // 2. 再监听热门产品集合
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('products')
              .where('isPopular', isEqualTo: true)
              .snapshots(),
          builder: (ctxProd, prodSnap) {
            if (!prodSnap.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final docs = prodSnap.data!.docs;
            if (docs.isEmpty) {
              return const Center(child: Text("No popular products."));
            }

            // 3. 把每个 doc 转成 Product，并根据 favList 动态设置 isFavourite
            final products = docs.map((doc) {
              final map = doc.data()! as Map<String, dynamic>;
              final p = Product.fromMap(map);
              final isFav = favList.contains(p.id.toString());
              return p.copyWith(isFavourite: isFav);
            }).toList();

            // 4. 渲染 UI
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SectionTitle(
                    title: "Popular Products",
                    press: () {
                      Navigator.pushNamed(
                        context,
                        ProductsScreen.routeName,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 20,
                    children: products.map((product) {
                      return SizedBox(
                        width: (screenWidth - 60) / 2,
                        child: ProductCard(
                          product: product,
                          onPress: () => Navigator.pushNamed(
                            context,
                            DetailsScreen.routeName,
                            arguments: ProductDetailsArguments(
                              productId: product.id.toString(),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:campets/screens/cart/cart_screen.dart';

// —— 新增这两行 —— 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/Product.dart';
import 'components/color_dots.dart';
import 'components/product_description.dart';
import 'components/product_images.dart';
import 'components/top_rounded_container.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1️⃣ 从 arguments 拿到 productId
    final args = ModalRoute.of(context)!.settings.arguments
        as ProductDetailsArguments;
    final productId = args.productId;

    // 2️⃣ 准备 Firestore 引用
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(uid);
    final prodRef =
        FirebaseFirestore.instance.collection('products').doc(productId);

    return FutureBuilder<DocumentSnapshot>(
      future: prodRef.get(),
      builder: (ctx, prodSnap) {
        if (prodSnap.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (!prodSnap.hasData || !prodSnap.data!.exists) {
          return const Scaffold(
            body: Center(child: Text("Product not found")),
          );
        }

        // 3️⃣ 拿到 Product 对象
        final data = prodSnap.data!.data()! as Map<String, dynamic>;
        final product = Product.fromMap(data);

        // 4️⃣ 按你原来的布局
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: const Color(0xFFF5F6F9),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: EdgeInsets.zero,
                  elevation: 0,
                  backgroundColor: Colors.white,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Text(
                      product.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset("assets/icons/Star Icon.svg"),
                  ],
                ),
              ),
            ],
          ),
          body: ListView(
            children: [
              ProductImages(product: product),
              TopRoundedContainer(
                color: Colors.white,
                child: Column(
                  children: [
                    ProductDescription(
                      product: product,
                      pressOnSeeMore: () {},
                    ),
                    TopRoundedContainer(
                      color: const Color(0xFFF6F7F9),
                      child: Column(
                        children: [
                          ColorDots(product: product),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: TopRoundedContainer(
            color: Colors.white,
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: ElevatedButton(
                  onPressed: () async {
                    // 5️⃣ 点击时，把 productId 写入 cart 子集合
                    final cartDoc = userRef
                        .collection('cart')
                        .doc(productId);
                    await cartDoc.set(
                      {
                        // 如果已存在 quantity 就 +1，否则初次设为 1
                        'quantity': FieldValue.increment(1),
                      },
                      SetOptions(merge: true),
                    );
                    // 跳转购物车
                    Navigator.pushNamed(context, CartScreen.routeName);
                  },
                  child: const Text("Add To Cart"),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// 这里只保留 productId，不再需要传整个 Product
class ProductDetailsArguments {
  final String productId;
  ProductDetailsArguments({required this.productId});
}

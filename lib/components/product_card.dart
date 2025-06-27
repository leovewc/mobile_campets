// lib/components/product_card.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Product.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onPress;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onPress,
  }) : super(key: key);

  Future<void> toggleFavorite(String productId, bool currentlyFav) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final userRef = FirebaseFirestore.instance.collection('users').doc(uid);

    if (currentlyFav) {
      await userRef.update({
        'favorites': FieldValue.arrayRemove([productId]),
      });
    } else {
      await userRef.update({
        'favorites': FieldValue.arrayUnion([productId]),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.asset(
                  product.images.first,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: InkWell(
                  onTap: () async {
                    await toggleFavorite(
                      product.id.toString(),
                      product.isFavourite,
                    );
                  },
                  child: Icon(
                    product.isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: product.isFavourite ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            product.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            "RM${product.price}",
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

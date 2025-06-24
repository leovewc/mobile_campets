import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../models/Product.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool expanded = false;
  bool isFavourite = false;

  @override
  void initState() {
    super.initState();
    isFavourite = widget.product.isFavourite; 
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            widget.product.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () async {
              final uid = FirebaseAuth.instance.currentUser!.uid;
              final userRef = FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid);

              final newFav = !isFavourite;
              if (newFav) {
                await userRef.update({
                  'favorites': FieldValue.arrayUnion(
                    [widget.product.id.toString()],
                  )
                });
              } else {
                await userRef.update({
                  'favorites': FieldValue.arrayRemove(
                    [widget.product.id.toString()],
                  )
                });
              }

              setState(() {
                isFavourite = newFav;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              width: 48,
              decoration: BoxDecoration(
                color: isFavourite
                    ? const Color(0xFFFFE6E6)
                    : const Color(0xFFF5F6F9),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: SvgPicture.asset(
                "assets/icons/Heart Icon_2.svg",
                colorFilter: ColorFilter.mode(
                  isFavourite
                      ? const Color(0xFFFF4848)
                      : const Color(0xFFDBDEE4),
                  BlendMode.srcIn,
                ),
                height: 16,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: expanded
              ? MarkdownBody(
            data: widget.product.description,
            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
              p: const TextStyle(fontSize: 14, height: 1.5),
            ),
          )
              : Text(
            widget.product.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: GestureDetector(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: Row(
              children: [
                Text(
                  expanded ? "Collapse Detail" : "See More Detail",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
                const SizedBox(width: 5),
                Icon(
                  expanded ? Icons.expand_less : Icons.arrow_forward_ios,
                  size: 12,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

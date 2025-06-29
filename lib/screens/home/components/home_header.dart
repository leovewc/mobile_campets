import 'package:flutter/material.dart';

import '../../cart/cart_screen.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';
import '../../profile/notification.dart';
import 'package:campets/screens/products/products_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// class HomeHeader extends StatelessWidget {
//   const HomeHeader({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Expanded(child: SearchField()),
//           const SizedBox(width: 16),
//           IconBtnWithCounter(
//             svgSrc: "assets/icons/Cart Icon.svg",
//             press: () => Navigator.pushNamed(context, CartScreen.routeName),
//           ),
//           const SizedBox(width: 8),
//           IconBtnWithCounter(
//             svgSrc: "assets/icons/Bell.svg",
//             numOfitem: 3,
//             press: () {
//               Navigator.pushNamed(context, NotificationScreen.routeName);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: SearchField(
              onSearchChanged: (query) {
                if (query.isNotEmpty) {
                  Navigator.pushNamed(
                    context,
                    ProductsScreen.routeName, // 跳转到搜索结果页
                    arguments: query,
                  );
                }
              },
            ),
          ),
          const SizedBox(width: 16),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            press: () => Navigator.pushNamed(context, "/cart"),
          ),
          const SizedBox(width: 8),
          StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('notifications')
              .where('isRead', isEqualTo: false)
              .snapshots(),
          builder: (context, snapshot) {
            int count = 0;
            if (snapshot.hasData) {
              count = snapshot.data!.docs.length;
            }

            return IconBtnWithCounter(
              svgSrc: "assets/icons/Bell.svg",
              numOfitem: count > 99 ? 99 : count,
              press: () => Navigator.pushNamed(context, NotificationScreen.routeName),
            );
          },
        ),
        ],
      ),
    );
  }

}


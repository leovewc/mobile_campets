import 'package:flutter/material.dart';

import '../../cart/cart_screen.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';
import '../../profile/notification.dart';
import 'package:campets/screens/products/products_screen.dart';
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
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfitem: 3,
            press: () => Navigator.pushNamed(context, "/notifications"),
          ),
        ],
      ),
    );
  }

}


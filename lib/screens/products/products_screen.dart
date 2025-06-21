import 'package:flutter/material.dart';
import 'package:campets/components/product_card.dart';
import 'package:campets/models/Product.dart';
import '../home/components/search_field.dart';
import '../details/details_screen.dart';
// class ProductsScreen extends StatefulWidget {
//   const ProductsScreen({super.key});
//
//   static String routeName = "/products";
//
//   @override
//   State<ProductsScreen> createState() => _ProductsScreenState();
// }

// class _ProductsScreenState extends State<ProductsScreen> {
//   List<Product> filteredProducts = demoProducts;
//
//   void _onSearchChanged(String query) {
//     setState(() {
//       filteredProducts = demoProducts
//           .where((product) =>
//           product.title.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Products")),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               const SizedBox(height: 16),
//               Expanded(
//                 child: GridView.builder(
//                   itemCount: filteredProducts.length,
//                   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                     maxCrossAxisExtent: 200,
//                     childAspectRatio: 0.7,
//                     mainAxisSpacing: 20,
//                     crossAxisSpacing: 16,
//                   ),
//                   itemBuilder: (context, index) => ProductCard(
//                     product: filteredProducts[index],
//                     onPress: () => Navigator.pushNamed(
//                       context,
//                       DetailsScreen.routeName,
//                       arguments: ProductDetailsArguments(
//                         product: filteredProducts[index],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class ProductsScreen extends StatelessWidget {
  final dynamic args;

  const ProductsScreen({super.key,  this.args});

  static String routeName = "/products";

  @override
  Widget build(BuildContext context) {
    // 获取搜索关键词参数（来自 Navigator.pushNamed）
    final args = ModalRoute.of(context)?.settings.arguments;
    String? query;
    String? category;

    if (args is String) {
      query = args;
    } else if (args is Map<String, dynamic>) {
      query = args['query'];
      category = args['category'];
    }

    // 根据 query 或 category 过滤产品
    List<Product> filteredProducts = demoProducts;
    if (query != null && query.isNotEmpty) {
      filteredProducts = filteredProducts
          .where((product) => product.title.toLowerCase().contains(query!.toLowerCase()))
          .toList();
    } else if (category != null && category.isNotEmpty) {
      filteredProducts = filteredProducts
          .where((product) => product.category.toLowerCase() == category!.toLowerCase())
          .toList();
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: filteredProducts.isEmpty
                    ? EmptyResult(keyword: query ?? "")
                    : GridView.builder(
                  itemCount: filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) => ProductCard(
                    product: filteredProducts[index],
                    onPress: () => Navigator.pushNamed(
                      context,
                      DetailsScreen.routeName,
                      arguments: ProductDetailsArguments(
                        product: filteredProducts[index],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

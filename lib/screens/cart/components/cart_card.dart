import 'package:flutter/material.dart';
import '../../../models/Product.dart';

class CartCard extends StatelessWidget {
  final Product product;
  final int quantity;
  final VoidCallback onRemove;
  final ValueChanged<int> onQuantityChanged;

  const CartCard({
    Key? key,
    required this.product,
    required this.quantity,
    required this.onRemove,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subtotal = product.price * quantity;
    
    // 确保卡片有最小高度
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 120),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // 图片 - 支持本地 asset 或网络
              SizedBox(
                width: 80,
                height: 80,
                child: product.images.isNotEmpty
                    ? _buildImage(product.images.first)
                    : const Icon(Icons.image, size: 40),
              ),
              const SizedBox(width: 12),

              // 商品信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${product.price.toStringAsFixed(2)} × $quantity = \$${subtotal.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    // 数量控制
                    _buildQuantityControls(),
                  ],
                ),
              ),

              // 删除按钮
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 28),
                onPressed: onRemove,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildQuantityControls() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: quantity > 1
              ? () => onQuantityChanged(quantity - 1)
              : null,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            quantity.toString(),
            style: const TextStyle(fontSize: 16),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle_outline),
          onPressed: () => onQuantityChanged(quantity + 1),
        ),
      ],
    );
  }

  Widget _buildImage(String path) {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
      );
    }
    return Image.asset(
      path,
      fit: BoxFit.cover,
    );
  }
}

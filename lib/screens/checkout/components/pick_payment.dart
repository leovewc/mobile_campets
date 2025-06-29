import 'package:flutter/material.dart';
import 'package:campets/constants.dart';

class EnhancedPaymentOptionTile extends StatelessWidget {
  final int index;
  final int? selectedIndex;
  final IconData? iconData;
  final String? assetPath;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const EnhancedPaymentOptionTile({
    Key? key,
    required this.index,
    required this.selectedIndex,
    this.iconData,
    this.assetPath,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : assert(iconData != null || assetPath != null,
            'iconData or assetPath must be provided'),
        super(key: key);

  bool get isSelected => selectedIndex == index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected 
                    ? kPrimaryColor 
                    : Colors.grey.withOpacity(0.2),
                width: isSelected ? 2 : 1,
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // 图标
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: _buildIcon(),
                ),
                
                const SizedBox(width: 12),
                
                // 文本
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // 选中指示器
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: kPrimaryColor,
                    size: 24,
                  )
                else
                  Icon(
                    Icons.radio_button_unchecked,
                    color: Colors.grey[400],
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (assetPath != null) {
      return Image.asset(
        assetPath!,
        width: 20,
        height: 20,
        fit: BoxFit.contain,
      );
    } else {
      return Icon(
        iconData,
        size: 20,
        color: Colors.grey[700],
      );
    }
  }
}
import 'package:flutter/material.dart';
import '../models/animal_post.dart';

class AnimalPostCard extends StatelessWidget {
  final AnimalPost post;
  final VoidCallback onTap;
  const AnimalPostCard({super.key, required this.post, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 图片区域
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              child: Image.asset(
                post.coverPath,
                fit: BoxFit.cover,
                height: 160,
                width: double.infinity,
              ),
            ),
            // 下方内容区：左侧两行，右下角状态+浪线
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // 左侧两行
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          post.species,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20, fontFamily: 'Muli'),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${post.gender}  ${post.age}',
                          style: const TextStyle(color: Colors.grey, fontSize: 13, fontFamily: 'Muli'),
                        ),
                      ],
                    ),
                  ),
                  // 右下角状态标签
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: post.status == AnimalStatus.available ? const Color(0xFFFF7643) : Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      post.status == AnimalStatus.available ? 'Available' : post.status == AnimalStatus.adopted ? 'Adopted' : 'Display',
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Muli'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF7643)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final path = Path();
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(size.width * 0.25, 0, size.width * 0.5, size.height / 2);
    path.quadraticBezierTo(size.width * 0.75, size.height, size.width, size.height / 2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 
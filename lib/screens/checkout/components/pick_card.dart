import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';



class CardListWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onCardSelected;
  final PageController controller;

  const CardListWidget({
    Key? key,
    required this.selectedIndex,
    required this.onCardSelected,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('paymentCards')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snap.data?.docs ?? [];
          if (docs.isEmpty) {
            return const Center(child: Text("No saved cards yet."));
          }
          return PageView.builder(
            controller: controller,
            itemCount: docs.length,
            physics: BouncingScrollPhysics(), 
            itemBuilder: (context, i) {
              final data = docs[i].data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: CardItem(
                  cardNumber: data['cardNumber'],
                  expiry: data['expiry'],
                  holder: data['cardHolder'],
                  selected: selectedIndex == i,
                  onTap: () {
                    if (i == selectedIndex) return;
                    controller.animateToPage(
                      i,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                    onCardSelected(i);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}


class CardItem extends StatefulWidget  {
  final String cardNumber;
  final String expiry;
  final String holder;
  final bool selected;
  final VoidCallback onTap;

  @override
  _CardItemState createState() => _CardItemState();

  const CardItem({
    Key? key,
    required this.cardNumber,
    required this.expiry,
    required this.holder,
    this.selected = false,
    required this.onTap,
  }) : super(key: key);

}

class _CardItemState extends State<CardItem>
    with AutomaticKeepAliveClientMixin<CardItem> {
  @override
  bool get wantKeepAlive => true; // 保持状态

  @override
  Widget build(BuildContext context) {
    super.build(context); 

    final masked = widget.cardNumber
        .replaceAllMapped(RegExp(r".{4}"), (m) => "${m.group(0)} ")
        .trim();

    final cardInner = Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            masked,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'VALID THRU',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.expiry,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.holder.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'VISA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );

    // 点击高亮
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: widget.selected
              ? [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  )
                ]
              : [],
        ),
        child: widget.selected
            ? ShinyBorderCard(borderWidth: 3, radius: 12, child: cardInner)
            : cardInner,
      ),
    );
  }
}



//选中效果
class ShinyBorderCard extends StatefulWidget {
  final Widget child;
  final double borderWidth;
  final double radius;
  const ShinyBorderCard({
    super.key,
    required this.child,
    this.borderWidth = 3.0,
    this.radius = 16.0,
  });

  @override
  State<ShinyBorderCard> createState() => _ShinyBorderCardState();
}

class _ShinyBorderCardState extends State<ShinyBorderCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final shimmerGradient = SweepGradient(
          startAngle: 0,
          endAngle: pi * 2,
          tileMode: TileMode.repeated,
          transform: GradientRotation(_controller.value * 2 * pi),
          colors: const [
            Colors.transparent,
            Colors.purple,
            Colors.cyan,
            Colors.blue,
            Colors.transparent,
          ],
          stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
        );

        return CustomPaint(
          painter: _ShinyBorderPainter(
            shimmerGradient,
            borderWidth: widget.borderWidth,
            radius: widget.radius,
          ),
          child: Container(
            padding: EdgeInsets.all(widget.borderWidth),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius),
              color: Colors.transparent,
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}

class _ShinyBorderPainter extends CustomPainter {
  final Gradient gradient;
  final double borderWidth;
  final double radius;

  _ShinyBorderPainter(this.gradient, {required this.borderWidth, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final rrect = RRect.fromRectAndRadius(
      rect.deflate(borderWidth / 2),
      Radius.circular(radius),
    );
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _ShinyBorderPainter oldDelegate) => true;
}



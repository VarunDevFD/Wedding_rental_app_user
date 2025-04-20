import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedCircleDialog extends StatelessWidget {
  const AnimatedCircleDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: AnimatedCirclesBackground(),
    );
  }
}

class AnimatedCirclesBackground extends StatefulWidget {
  const AnimatedCirclesBackground({super.key});

  @override
  _AnimatedCirclesBackgroundState createState() =>
      _AnimatedCirclesBackgroundState();
}

class _AnimatedCirclesBackgroundState extends State<AnimatedCirclesBackground>
    with TickerProviderStateMixin {
  final List<CircleData> circles = [];
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize circles
    for (int i = 0; i < 16; i++) {
      circles.add(CircleData(
        position: Offset(
          Random().nextDouble() * 300,
          Random().nextDouble() * 200,
        ),
        color: Color.fromRGBO(
          Random().nextInt(255),
          Random().nextInt(255),
          Random().nextInt(255),
          0.3,
        ),
        size: 20 + Random().nextDouble() * 40,
        speed: Offset(
          (Random().nextDouble() - 0.5) * 2,
          (Random().nextDouble() - 0.5) * 2,
        ),
      ));
    }

    // Animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16), // ~60fps
    )..addListener(() {
        updateCircles();
      });

    _controller.repeat();
  }

  void updateCircles() {
    for (var circle in circles) {
      circle.position += circle.speed;

      // Bounce off edges
      if (circle.position.dx < 0 || circle.position.dx > 500   ) {
        circle.speed = Offset(-circle.speed.dx, circle.speed.dy);
      }
      if (circle.position.dy < 0 || circle.position.dy > 200) {
        circle.speed = Offset(circle.speed.dx, -circle.speed.dy);
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 950,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CustomPaint(
          painter: CirclesPainter(circles),
          size: const Size(950, 260),
        ),
      ),
    );
  }
}

class CircleData {
  Offset position;
  Color color;
  double size;
  Offset speed;

  CircleData({
    required this.position,
    required this.color,
    required this.size,
    required this.speed,
  });
}

class CirclesPainter extends CustomPainter {
  final List<CircleData> circles;

  CirclesPainter(this.circles);

  @override
  void paint(Canvas canvas, Size size) {
    for (var circle in circles) {
      final paint = Paint()
        ..color = circle.color
        ..style = PaintingStyle.fill;

      canvas.drawCircle(circle.position, circle.size, paint);
    }
  }

  @override
  bool shouldRepaint(CirclesPainter oldDelegate) => true;
}

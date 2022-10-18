import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../commons.dart';

class LogoHomeAnimation extends StatefulWidget {
  const LogoHomeAnimation({Key? key}) : super(key: key);

  @override
  State<LogoHomeAnimation> createState() => _LogoHomeAnimationState();
}

class _LogoHomeAnimationState extends State<LogoHomeAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();

    return AnimatedBuilder(
      animation: controller,
      child: const CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage(Commons.logoSquarePath),
      ),
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: controller.value * 2.0 * math.pi,
          child: child,
        );
      },
    );
  }
}

import 'dart:math' as math;
import 'package:flutter/material.dart';

class FlipPageRoute<T> extends PageRouteBuilder<T> {
  FlipPageRoute({required Widget page})
      : super(
          transitionDuration: const Duration(milliseconds: 700),
          reverseTransitionDuration: const Duration(milliseconds: 700),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AnimatedBuilder(
              animation: animation,
              child: child,
              builder: (context, child) {
                final t = Curves.easeInOutCubic.transform(animation.value);
                final angle = -(1 - t) * math.pi / 2; // -90° -> 0°
                return Transform(
                  alignment: Alignment.centerLeft, // the "spine"
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.0012) // perspective
                    ..rotateY(angle),
                  child: child,
                );
              },
            );
          },
        );
}
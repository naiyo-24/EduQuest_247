import 'package:flutter/material.dart';

class BurstTransition extends PageRouteBuilder {
  final Widget page;

  BurstTransition({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            var scale = Tween(begin: begin, end: end).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOutCubicEmphasized,
              ),
            );

            var opacity = Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
            );

            return Transform.scale(
              scale: Curves.elasticOut.transform(scale.value),
              child: FadeTransition(
                opacity: opacity,
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 100),
          reverseTransitionDuration: const Duration(milliseconds: 100),
        );
}

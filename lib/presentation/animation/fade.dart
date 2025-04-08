import 'package:flutter/material.dart';


class FadePageTransition extends PageRouteBuilder {

  FadePageTransition({required this.page})

      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(seconds: 1),
        );
  final Widget page;
}

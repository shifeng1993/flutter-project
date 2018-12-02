import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RouteBuilder {
  static final Function fade = (Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, _, __) {
        return page;
      },
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: FadeTransition(
            opacity: Tween(begin: 0.5, end: 1.0).animate(animation),
            child: child,
          ),
        );
      },
    );
  };
}

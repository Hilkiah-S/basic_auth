import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;

  CustomBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF98FB98), Color(0xFF800080)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: child,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NeoContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool isPressed;

  const NeoContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.isPressed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(20),
        boxShadow: isPressed
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(2, 2),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: const Color(0xFF1DB954).withOpacity(0.1),
                  offset: const Offset(-2, -2),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  offset: const Offset(8, 8),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: const Color(0xFF1DB954).withOpacity(0.1),
                  offset: const Offset(-4, -4),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
      ),
      child: child,
    );
  }
}
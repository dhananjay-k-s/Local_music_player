import 'package:flutter/material.dart';

class NeoButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final bool isPressed;
  final Color btnBackGroundColor;
  final blureFirsColor;
  final blureSecondColor;

  const NeoButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.padding,
    this.isPressed = false,
    this.btnBackGroundColor = const Color(0xFF2A2A2A),
    this.blureFirsColor = const Color(0xFF1A1A1A),
    this.blureSecondColor = const Color(0xFF1DB954),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: padding ?? const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: btnBackGroundColor,
          boxShadow: isPressed
              ? [
                  BoxShadow(
                    color: blureFirsColor.withOpacity(0.3),
                    offset: const Offset(2, 2),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: blureSecondColor.withOpacity(0.1),
                    offset: const Offset(-2, -2),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ]
              : [
                  BoxShadow(
                    color: blureFirsColor.withOpacity(0.4),
                    offset: const Offset(6, 6),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: blureSecondColor.withOpacity(0.1),
                    offset: const Offset(-4, -4),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
        ),
        child: Center(
          child: IconTheme(
            data: IconThemeData(
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

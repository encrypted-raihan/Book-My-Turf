import 'package:flutter/material.dart';

class NeonBlob extends StatelessWidget {
  final Color color;
  final Alignment alignment;
  final double size;

  const NeonBlob({
    super.key,
    required this.color,
    required this.alignment,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withOpacity(0.35),
              color.withOpacity(0.15),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}

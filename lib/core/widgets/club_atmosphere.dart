import 'package:flutter/material.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';

class ClubAtmosphere extends StatelessWidget {
  const ClubAtmosphere({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned.fill(child: ColoredBox(color: AppColors.background)),
        Positioned(
          top: -140,
          right: -90,
          child: _Glow(size: 460, color: Color(0x66E10600)),
        ),
        Positioned(
          top: 420,
          left: -160,
          child: _Glow(size: 380, color: Color(0x33E10600)),
        ),
      ],
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, const Color(0x00000000)]),
        ),
      ),
    );
  }
}

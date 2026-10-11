import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hetman_boxing_club/app/router/app_routes.dart';

class ClubEmblem extends StatelessWidget {
  const ClubEmblem({required this.size, this.radius, super.key});

  final double size;
  final double? radius;

  static const asset = 'assets/images/logo.jpg';

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? size * 0.16),
      child: Image.asset(
        asset,
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}

class HetmanLogo extends StatelessWidget {
  const HetmanLogo({this.compact = false, super.key});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 48.0 : 72.0;
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () => context.go(AppRoutes.home),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          child: ClubEmblem(size: size),
        ),
      ),
    );
  }
}

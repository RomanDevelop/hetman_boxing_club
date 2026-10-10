import 'package:flutter/material.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';

class ClubPhoto extends StatelessWidget {
  const ClubPhoto({
    required this.url,
    this.fit = BoxFit.cover,
    super.key,
  });

  final String url;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: fit,
      gaplessPlayback: true,
      errorBuilder: (context, error, stackTrace) => const ClubPhotoFallback(),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const ClubPhotoFallback();
      },
    );
  }
}

class ClubPhotoFallback extends StatelessWidget {
  const ClubPhotoFallback({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3A1014), Color(0xFF12080A), Color(0xFF1A1A1E)],
        ),
      ),
      child: Center(
        child: Icon(Icons.sports_mma, color: AppColors.red, size: 56),
      ),
    );
  }
}

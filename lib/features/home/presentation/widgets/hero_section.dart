import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hetman_boxing_club/app/router/app_routes.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';
import 'package:hetman_boxing_club/app/theme/app_typography.dart';
import 'package:hetman_boxing_club/core/constants/club_photos.dart';
import 'package:hetman_boxing_club/core/layout/breakpoints.dart';
import 'package:hetman_boxing_club/core/widgets/club_photo.dart';
import 'package:hetman_boxing_club/core/widgets/hetman_button.dart';
import 'package:hetman_boxing_club/features/home/presentation/view_model/home_view_model.dart';
import 'package:hetman_boxing_club/features/home/presentation/widgets/video_dialog.dart';

class HeroSection extends ConsumerWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hero = ref.watch(homeViewModelProvider).hero;
    final wide = MediaQuery.sizeOf(context).width >= Breakpoints.desktop;

    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(hero.kicker, style: AppTypography.display(wide ? 22 : 18, style: FontStyle.italic)),
        const SizedBox(height: 8),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(hero.title, style: AppTypography.display(wide ? 76 : 52)),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(hero.accent, style: AppTypography.display(wide ? 76 : 52, color: AppColors.redBright)),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(hero.body, style: AppTypography.body(size: wide ? 16 : 14)),
        ),
        const SizedBox(height: 22),
        if (wide)
          Row(
            children: [
              HetmanButton(
                label: 'ZAPISZ SIĘ NA DARMOWY TRENING',
                icon: Icons.arrow_forward,
                onPressed: () => context.go(AppRoutes.enroll),
              ),
              const SizedBox(width: 12),
              HetmanButton(
                label: 'ZOBACZ WIDEO',
                leading: Icons.play_arrow_rounded,
                variant: HetmanButtonVariant.outline,
                onPressed: () => showVideoDialog(context),
              ),
            ],
          )
        else ...[
          HetmanButton(
            label: 'ZAPISZ SIĘ NA DARMOWY TRENING',
            icon: Icons.arrow_forward,
            expanded: true,
            onPressed: () => context.go(AppRoutes.enroll),
          ),
          const SizedBox(height: 10),
          HetmanButton(
            label: 'ZOBACZ WIDEO',
            leading: Icons.play_arrow_rounded,
            variant: HetmanButtonVariant.outline,
            expanded: true,
            onPressed: () => showVideoDialog(context),
          ),
        ],
      ],
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.08, end: 0, duration: 500.ms);

    if (!wide) {
      return Stack(
        fit: StackFit.expand,
        children: [
          const ClubPhoto(url: ClubPhotos.boxer),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x33000000),
                  Color(0x66000000),
                  Color(0xE6070708),
                  AppColors.background,
                ],
                stops: [0, 0.28, 0.72, 1],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                copy,
              ],
            ),
          ),
        ],
      );
    }

    return SizedBox(
      height: 640,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const Row(
            children: [
              Spacer(flex: 4),
              Expanded(flex: 6, child: ClubPhoto(url: ClubPhotos.crowd)),
            ],
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  AppColors.background,
                  AppColors.background,
                  Color(0xCC070708),
                  Color(0x00070708),
                ],
                stops: [0, 0.34, 0.52, 0.78],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(48, 36, 48, 36),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: copy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

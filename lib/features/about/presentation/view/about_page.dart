import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hetman_boxing_club/app/router/app_routes.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';
import 'package:hetman_boxing_club/app/theme/app_typography.dart';
import 'package:hetman_boxing_club/core/constants/club_photos.dart';
import 'package:hetman_boxing_club/core/widgets/club_photo.dart';
import 'package:hetman_boxing_club/core/widgets/club_scroll_view.dart';
import 'package:hetman_boxing_club/core/widgets/hetman_button.dart';
import 'package:hetman_boxing_club/features/about/presentation/view_model/about_view_model.dart';
import 'package:hetman_boxing_club/features/achievements/presentation/widgets/achievements_section.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final about = ref.watch(aboutViewModelProvider);
    return ClubScrollView(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: SizedBox(
            height: 220,
            child: Stack(
              fit: StackFit.expand,
              children: [
                const ClubPhoto(url: ClubPhotos.ring),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xCC070708), Color(0x66070708)],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(about.title, style: AppTypography.display(48)),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        Text(about.body, style: AppTypography.body(size: 18, color: AppColors.textPrimary)),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final value in about.values)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: AppColors.red),
                ),
                child: Text(value, style: AppTypography.button(size: 14)),
              ),
          ],
        ),
        const SizedBox(height: 28),
        const AchievementsSection(),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: HetmanButton(
            label: 'DOŁĄCZ PRZEZ WHATSAPP',
            icon: Icons.arrow_forward,
            onPressed: () => context.go(AppRoutes.enroll),
          ),
        ),
      ],
    );
  }
}

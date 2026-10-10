import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hetman_boxing_club/app/router/app_routes.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';
import 'package:hetman_boxing_club/app/theme/app_typography.dart';
import 'package:hetman_boxing_club/core/icons/club_icons.dart';
import 'package:hetman_boxing_club/core/widgets/club_card.dart';
import 'package:hetman_boxing_club/core/widgets/club_photo.dart';
import 'package:hetman_boxing_club/core/widgets/section_header.dart';
import 'package:hetman_boxing_club/features/club/domain/club_domain.dart';
import 'package:hetman_boxing_club/features/groups/presentation/view_model/groups_view_model.dart';

class GroupsSection extends ConsumerWidget {
  const GroupsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(groupsViewModelProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: 'NASZE GRUPY TRENINGOWE',
          actionLabel: 'ZAPISZ SIĘ NA DARMOWY TRENING',
          onAction: () => context.go(AppRoutes.enroll),
        ),
        const SizedBox(height: 22),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final columns = width >= 1000 ? 4 : width >= 680 ? 2 : 1;
            final cardWidth = (width - (16 * (columns - 1))) / columns;
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                for (var i = 0; i < groups.length; i++)
                  SizedBox(
                    width: cardWidth,
                    child: _GroupCard(group: groups[i])
                        .animate(delay: (70 * i).ms)
                        .fadeIn(duration: 400.ms)
                        .slideY(begin: 0.06, end: 0),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _GroupCard extends StatelessWidget {
  const _GroupCard({required this.group});

  final TrainingGroup group;

  @override
  Widget build(BuildContext context) {
    return ClubCard(
      onTap: () => context.go(AppRoutes.enrollFor(group.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 10,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClubPhoto(url: group.imageUrl),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0x22000000), Color(0xCC070708)],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(group.title, style: AppTypography.display(28)),
                Text(group.ageLabel, style: AppTypography.title(16, color: AppColors.textSecondary)),
                const SizedBox(height: 8),
                Text(group.summary, style: AppTypography.body(size: 13)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 6,
                  children: [
                    for (final tag in group.tags)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(clubIcon(tag.iconKey), size: 14, color: AppColors.redBright),
                          const SizedBox(width: 4),
                          Text(tag.label, style: AppTypography.body(size: 12, color: AppColors.textPrimary)),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 14),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(color: AppColors.red, shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

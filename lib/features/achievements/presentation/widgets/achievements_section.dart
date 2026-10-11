import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';
import 'package:hetman_boxing_club/app/theme/app_typography.dart';
import 'package:hetman_boxing_club/core/icons/club_icons.dart';
import 'package:hetman_boxing_club/core/widgets/section_header.dart';
import 'package:hetman_boxing_club/features/achievements/presentation/view_model/achievements_view_model.dart';
import 'package:hetman_boxing_club/features/club/domain/club_domain.dart';

class AchievementsSection extends ConsumerWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(achievementsViewModelProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionHeader(title: 'NASZE OSIĄGNIĘCIA'),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final strip = constraints.maxWidth >= 900;
            if (!strip) {
              return Column(
                children: [for (final item in items) _AchievementTile(item: item)],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < items.length; i++) ...[
                  if (i > 0) const SizedBox(width: 18),
                  Expanded(child: _AchievementTile(item: items[i], compact: true)),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}

class _AchievementTile extends StatelessWidget {
  const _AchievementTile({required this.item, this.compact = false});

  final Achievement item;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final icon = Icon(clubIcon(item.iconKey), color: AppColors.gold, size: compact ? 26 : 28);
    final title = Text(item.title, style: AppTypography.body(size: 16, color: AppColors.textPrimary));

    if (compact) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          const SizedBox(width: 10),
          Expanded(child: title),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 12),
          Expanded(child: title),
        ],
      ),
    );
  }
}

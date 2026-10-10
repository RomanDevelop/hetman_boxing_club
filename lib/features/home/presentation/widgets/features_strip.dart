import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';
import 'package:hetman_boxing_club/app/theme/app_typography.dart';
import 'package:hetman_boxing_club/core/icons/club_icons.dart';
import 'package:hetman_boxing_club/features/home/presentation/view_model/home_view_model.dart';

class FeaturesStrip extends ConsumerWidget {
  const FeaturesStrip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final home = ref.watch(homeViewModelProvider);
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 980;
        final features = [
          for (var i = 0; i < home.features.length; i++)
            _FeatureTile(iconKey: home.features[i].iconKey, title: home.features[i].title)
                .animate(delay: (50 * i).ms)
                .fadeIn(duration: 350.ms),
        ];

        final stat = _MembersStat(count: home.membersCount, caption: home.membersCaption);

        if (!wide) {
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [...features, stat],
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          ),
          child: Row(
            children: [
              for (final feature in features) ...[
                Expanded(child: feature),
                const SizedBox(width: 4),
              ],
              stat,
            ],
          ),
        );
      },
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({required this.iconKey, required this.title});

  final String iconKey;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Column(
        children: [
          Icon(clubIcon(iconKey), color: AppColors.redBright, size: 26),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypography.body(size: 13, color: AppColors.textPrimary, height: 1.25),
          ),
        ],
      ),
    );
  }
}

class _MembersStat extends StatelessWidget {
  const _MembersStat({required this.count, required this.caption});

  final int count;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 180),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.red.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.red),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.groups, color: AppColors.redBright),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$count+', style: AppTypography.display(28)),
              Text(caption, style: AppTypography.label(size: 11, color: AppColors.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }
}

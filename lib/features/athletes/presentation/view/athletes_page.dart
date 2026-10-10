import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';
import 'package:hetman_boxing_club/app/theme/app_typography.dart';
import 'package:hetman_boxing_club/core/widgets/club_card.dart';
import 'package:hetman_boxing_club/core/widgets/club_scroll_view.dart';
import 'package:hetman_boxing_club/core/widgets/section_header.dart';
import 'package:hetman_boxing_club/features/athletes/presentation/view_model/athletes_view_model.dart';

class AthletesPage extends ConsumerWidget {
  const AthletesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final athletes = ref.watch(athletesViewModelProvider);
    return ClubScrollView(
      children: [
        const SectionHeader(title: 'ZAWODNICY'),
        const SizedBox(height: 8),
        Text(
          '120+ osób w jednej drużynie. Poniżej kilka historii z tego sezonu.',
          style: AppTypography.body(),
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 800 ? 2 : 1;
            final width = (constraints.maxWidth - 14 * (columns - 1)) / columns;
            return Wrap(
              spacing: 14,
              runSpacing: 14,
              children: [
                for (final athlete in athletes)
                  SizedBox(
                    width: width,
                    child: ClubCard(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        children: [
                          Container(
                            width: 54,
                            height: 54,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.red.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Text('${athlete.medals}', style: AppTypography.display(24)),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(athlete.name, style: AppTypography.title(22)),
                                Text(athlete.category, style: AppTypography.label(color: AppColors.redBright)),
                                const SizedBox(height: 4),
                                Text(athlete.highlight, style: AppTypography.body(size: 14)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

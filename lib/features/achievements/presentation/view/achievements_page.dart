import 'package:flutter/material.dart';
import 'package:hetman_boxing_club/app/theme/app_typography.dart';
import 'package:hetman_boxing_club/core/widgets/club_scroll_view.dart';
import 'package:hetman_boxing_club/features/achievements/presentation/widgets/achievements_section.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClubScrollView(
      children: [
        const AchievementsSection(),
        const SizedBox(height: 8),
        Text(
          'Medale są skutkiem pracy, nie celem samym w sobie. Liczy się droga zawodnika od pierwszego treningu.',
          style: AppTypography.body(),
        ),
      ],
    );
  }
}

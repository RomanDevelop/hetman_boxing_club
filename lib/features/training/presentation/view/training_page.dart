import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hetman_boxing_club/app/router/app_routes.dart';
import 'package:hetman_boxing_club/core/widgets/club_scroll_view.dart';
import 'package:hetman_boxing_club/core/widgets/hetman_button.dart';
import 'package:hetman_boxing_club/features/training/presentation/widgets/training_section.dart';

class TrainingPage extends StatelessWidget {
  const TrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClubScrollView(
      children: [
        const TrainingSection(),
        const SizedBox(height: 28),
        Align(
          alignment: Alignment.centerLeft,
          child: HetmanButton(
            label: 'NASZE GRUPY',
            icon: Icons.arrow_forward,
            variant: HetmanButtonVariant.outline,
            onPressed: () => context.go(AppRoutes.groups),
          ),
        ),
      ],
    );
  }
}

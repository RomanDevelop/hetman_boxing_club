import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hetman_boxing_club/app/router/app_routes.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';
import 'package:hetman_boxing_club/app/theme/app_typography.dart';
import 'package:hetman_boxing_club/core/widgets/club_card.dart';
import 'package:hetman_boxing_club/core/widgets/club_photo.dart';
import 'package:hetman_boxing_club/core/widgets/hetman_button.dart';
import 'package:hetman_boxing_club/core/widgets/section_header.dart';
import 'package:hetman_boxing_club/features/club/domain/club_domain.dart';
import 'package:hetman_boxing_club/features/trainers/presentation/view_model/trainers_view_model.dart';

class TrainersSection extends ConsumerWidget {
  const TrainersSection({this.linked = true, super.key});

  final bool linked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainers = ref.watch(trainersViewModelProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: 'NASI TRENERZY',
          actionLabel: linked ? 'POZNAJ CAŁY ZESPÓŁ' : null,
          onAction: linked ? () => context.go(AppRoutes.trainers) : null,
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 860 ? 3 : 1;
            final width = (constraints.maxWidth - 16 * (columns - 1)) / columns;
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                for (var i = 0; i < trainers.length; i++)
                  SizedBox(
                    width: width,
                    child: _TrainerCard(trainer: trainers[i])
                        .animate(delay: (70 * i).ms)
                        .fadeIn(duration: 350.ms),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _TrainerCard extends StatelessWidget {
  const _TrainerCard({required this.trainer});

  final Trainer trainer;

  @override
  Widget build(BuildContext context) {
    return ClubCard(
      onTap: () => showDialog<void>(
        context: context,
        builder: (context) => _TrainerDialog(trainer: trainer),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(aspectRatio: 16 / 11, child: ClubPhoto(url: trainer.imageUrl)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(trainer.name, style: AppTypography.display(28, style: FontStyle.normal)),
                Text(trainer.role, style: AppTypography.body(size: 13, color: AppColors.redBright)),
                const SizedBox(height: 8),
                Text(trainer.summary, style: AppTypography.body(size: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TrainerDialog extends StatelessWidget {
  const _TrainerDialog({required this.trainer});

  final Trainer trainer;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(trainer.name, style: AppTypography.display(36, style: FontStyle.normal)),
              Text(trainer.role, style: AppTypography.body(color: AppColors.redBright)),
              const SizedBox(height: 12),
              Text(trainer.bio, style: AppTypography.body(color: AppColors.textPrimary)),
              const SizedBox(height: 16),
              HetmanButton(label: 'ZAMKNIJ', onPressed: () => Navigator.pop(context)),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hetman_boxing_club/app/router/app_routes.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';
import 'package:hetman_boxing_club/app/theme/app_typography.dart';
import 'package:hetman_boxing_club/core/widgets/club_card.dart';
import 'package:hetman_boxing_club/core/widgets/hetman_button.dart';
import 'package:hetman_boxing_club/core/widgets/section_header.dart';
import 'package:hetman_boxing_club/features/club/domain/club_domain.dart';
import 'package:hetman_boxing_club/features/schedule/presentation/view_model/schedule_view_model.dart';

const _days = [
  (0, 'Pon'),
  (1, 'Wt'),
  (2, 'Śr'),
  (3, 'Czw'),
  (4, 'Pt'),
  (5, 'Sob'),
];

class ScheduleSection extends ConsumerWidget {
  const ScheduleSection({this.linked = true, super.key});

  final bool linked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scheduleViewModelProvider);
    final notifier = ref.read(scheduleViewModelProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionHeader(title: 'GRAFIK TRENINGÓW'),
        const SizedBox(height: 16),
        Row(
          children: [
            for (final day in _days)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: _DayChip(
                    label: day.$2,
                    selected: state.selectedDay == day.$1,
                    onTap: () => notifier.selectDay(day.$1),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Column(
            key: ValueKey(state.selectedDay),
            children: [
              if (state.visible.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    'W tym dniu nie ma treningów.',
                    style: AppTypography.body(),
                  ),
                )
              else
                for (var i = 0; i < state.visible.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _SessionCard(session: state.visible[i])
                        .animate(delay: (40 * i).ms)
                        .fadeIn(duration: 280.ms)
                        .slideX(begin: 0.04, end: 0),
                  ),
            ],
          ),
        ),
        if (linked)
          Align(
            alignment: Alignment.centerLeft,
            child: HetmanButton(
              label: 'ZOBACZ PEŁNY GRAFIK',
              icon: Icons.arrow_forward,
              variant: HetmanButtonVariant.text,
              onPressed: () => context.go(AppRoutes.schedule),
            ),
          ),
      ],
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: selected ? AppColors.red : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTypography.title(14, color: selected ? Colors.white : AppColors.textSecondary),
          ),
        ),
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({required this.session});

  final ScheduleSession session;

  @override
  Widget build(BuildContext context) {
    final percent = (session.fill * 100).round();
    return ClubCard(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 560;
          final details = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(session.groupName, style: AppTypography.body(size: 15, color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text('${session.enrolled}/${session.capacity}', style: AppTypography.label(size: 13, color: AppColors.textSecondary)),
                  const Spacer(),
                  Text('$percent%', style: AppTypography.label(size: 13, color: AppColors.textPrimary)),
                ],
              ),
              const SizedBox(height: 6),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: session.fill),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                builder: (context, value, _) {
                  return Semantics(
                    excludeSemantics: true,
                    child: LinearProgressIndicator(
                      value: value,
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  );
                },
              ),
            ],
          );

          final button = HetmanButton(
            label: 'ZAPISZ SIĘ',
            icon: Icons.arrow_forward,
            variant: HetmanButtonVariant.text,
            onPressed: () => context.go(AppRoutes.enrollFor(session.groupId)),
          );

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(session.timeRange, style: AppTypography.title(20))),
                    button,
                  ],
                ),
                const SizedBox(height: 8),
                details,
              ],
            );
          }

          return Row(
            children: [
              SizedBox(width: 130, child: Text(session.timeRange, style: AppTypography.title(18))),
              Expanded(child: details),
              button,
            ],
          );
        },
      ),
    );
  }
}

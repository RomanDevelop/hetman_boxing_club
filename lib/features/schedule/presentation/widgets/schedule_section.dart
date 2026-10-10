import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hetman_boxing_club/app/router/app_routes.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';
import 'package:hetman_boxing_club/app/theme/app_typography.dart';
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
        const SizedBox(height: 12),
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
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _SessionCard(session: state.visible[i])
                        .animate(delay: (40 * i).ms)
                        .fadeIn(duration: 280.ms),
                  ),
            ],
          ),
        ),
        if (linked)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => context.go(AppRoutes.schedule),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Zobacz pełny grafik',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                ],
              ),
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
        color: selected ? AppColors.red : const Color(0xFF1A1A20),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTypography.title(15, color: Colors.white),
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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFF141418),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 520;
            final dot = _AccentDot(color: _accentColor(session.accent));
            final time = Text(
              session.timeRange,
              maxLines: 1,
              style: AppTypography.title(wide ? 18 : 16),
            );
            final name = Text(
              session.groupName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.manrope(
                fontSize: wide ? 15 : 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                height: 1.2,
              ),
            );
            final occupancy = _Occupancy(enrolled: session.enrolled, capacity: session.capacity);
            final enroll = _EnrollPill(
              onPressed: () => context.go(AppRoutes.enrollFor(session.groupId)),
            );

            if (!wide) {
              return Row(
                children: [
                  dot,
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        time,
                        const SizedBox(height: 2),
                        name,
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      occupancy,
                      const SizedBox(height: 6),
                      enroll,
                    ],
                  ),
                ],
              );
            }

            return Row(
              children: [
                dot,
                const SizedBox(width: 12),
                time,
                const SizedBox(width: 16),
                Expanded(child: name),
                const SizedBox(width: 12),
                occupancy,
                const SizedBox(width: 14),
                enroll,
              ],
            );
          },
        ),
      ),
    );
  }
}

class _AccentDot extends StatelessWidget {
  const _AccentDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _Occupancy extends StatelessWidget {
  const _Occupancy({required this.enrolled, required this.capacity});

  final int enrolled;
  final int capacity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.people_outline, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          '$enrolled/$capacity',
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
            height: 1,
          ),
        ),
      ],
    );
  }
}

class _EnrollPill extends StatelessWidget {
  const _EnrollPill({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.red,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            'Zapisz się',
            style: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}

Color _accentColor(SessionAccent accent) {
  return switch (accent) {
    SessionAccent.green => const Color(0xFF3DDE6A),
    SessionAccent.blue => const Color(0xFF3B7BFF),
    SessionAccent.violet => const Color(0xFF8E5CFF),
    SessionAccent.gold => const Color(0xFFE6B23C),
  };
}

import 'package:flutter/material.dart';
import 'package:hetman_boxing_club/core/widgets/club_scroll_view.dart';
import 'package:hetman_boxing_club/features/schedule/presentation/widgets/schedule_section.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClubScrollView(
      children: [ScheduleSection(linked: false)],
    );
  }
}

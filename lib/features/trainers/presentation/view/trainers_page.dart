import 'package:flutter/material.dart';
import 'package:hetman_boxing_club/core/widgets/club_scroll_view.dart';
import 'package:hetman_boxing_club/features/trainers/presentation/widgets/trainers_section.dart';

class TrainersPage extends StatelessWidget {
  const TrainersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClubScrollView(
      children: [TrainersSection(linked: false)],
    );
  }
}

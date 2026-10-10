import 'package:flutter/material.dart';
import 'package:hetman_boxing_club/core/widgets/club_scroll_view.dart';
import 'package:hetman_boxing_club/features/groups/presentation/widgets/groups_section.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClubScrollView(children: [GroupsSection()]);
  }
}

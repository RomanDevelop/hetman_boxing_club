import 'package:flutter/material.dart';
import 'package:hetman_boxing_club/app/theme/app_typography.dart';
import 'package:hetman_boxing_club/core/widgets/hetman_button.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final stacked = constraints.maxWidth < 900;
        final titleWidget = Text(title, style: AppTypography.display(stacked ? 34 : 44));
        final action = actionLabel == null
            ? null
            : HetmanButton(
                label: actionLabel!,
                icon: Icons.arrow_forward,
                onPressed: onAction,
              );

        if (stacked || action == null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleWidget,
              if (action != null) ...[const SizedBox(height: 16), action],
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: titleWidget),
            const SizedBox(width: 16),
            action,
          ],
        );
      },
    );
  }
}

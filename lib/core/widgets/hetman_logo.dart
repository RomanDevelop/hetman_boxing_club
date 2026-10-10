import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hetman_boxing_club/app/router/app_routes.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';
import 'package:hetman_boxing_club/app/theme/app_typography.dart';
import 'package:hetman_boxing_club/features/home/presentation/view_model/home_view_model.dart';

class HetmanLogo extends ConsumerWidget {
  const HetmanLogo({this.compact = false, super.key});

  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brand = ref.watch(homeViewModelProvider).brand;
    return InkWell(
      onTap: () => context.go(AppRoutes.home),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: compact ? 38 : 44,
              height: compact ? 38 : 44,
              decoration: BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.red.withValues(alpha: 0.4),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: const Icon(Icons.sports_mma, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(brand.overline, style: AppTypography.label(size: 10, color: AppColors.textMuted, spacing: 1.6)),
                Text(brand.name, style: AppTypography.title(compact ? 16 : 18)),
                if (!compact)
                  Text(brand.city, style: AppTypography.label(size: 10, color: AppColors.redBright, spacing: 1.8)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

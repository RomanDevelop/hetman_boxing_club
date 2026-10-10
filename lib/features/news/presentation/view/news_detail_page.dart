import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hetman_boxing_club/app/router/app_routes.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';
import 'package:hetman_boxing_club/app/theme/app_typography.dart';
import 'package:hetman_boxing_club/core/format/club_date.dart';
import 'package:hetman_boxing_club/core/widgets/club_photo.dart';
import 'package:hetman_boxing_club/core/widgets/club_scroll_view.dart';
import 'package:hetman_boxing_club/core/widgets/hetman_button.dart';
import 'package:hetman_boxing_club/features/news/presentation/view_model/news_view_model.dart';

class NewsDetailPage extends ConsumerWidget {
  const NewsDetailPage({required this.postId, super.key});

  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(newsDetailViewModelProvider(postId));
    if (post == null) {
      return ClubScrollView(
        children: [
          Text('Nie znaleziono aktualności.', style: AppTypography.body()),
          const SizedBox(height: 16),
          HetmanButton(label: 'WRÓĆ', onPressed: () => context.go(AppRoutes.news)),
        ],
      );
    }

    return ClubScrollView(
      children: [
        HetmanButton(
          label: 'AKTUALNOŚCI',
          leading: Icons.arrow_back,
          variant: HetmanButtonVariant.text,
          onPressed: () => context.go(AppRoutes.news),
        ),
        const SizedBox(height: 8),
        Text(ClubDate.short(post.date), style: AppTypography.label(color: AppColors.redBright)),
        const SizedBox(height: 8),
        Text(post.title, style: AppTypography.display(48)),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: AspectRatio(aspectRatio: 16 / 7, child: ClubPhoto(url: post.imageUrl)),
        ),
        const SizedBox(height: 18),
        for (final paragraph in post.body.split('\n\n')) ...[
          Text(paragraph, style: AppTypography.body(size: 16, color: AppColors.textPrimary)),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

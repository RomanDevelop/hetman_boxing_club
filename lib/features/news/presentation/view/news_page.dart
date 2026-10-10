import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hetman_boxing_club/app/router/app_routes.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';
import 'package:hetman_boxing_club/app/theme/app_typography.dart';
import 'package:hetman_boxing_club/core/format/club_date.dart';
import 'package:hetman_boxing_club/core/widgets/club_card.dart';
import 'package:hetman_boxing_club/core/widgets/club_photo.dart';
import 'package:hetman_boxing_club/core/widgets/club_scroll_view.dart';
import 'package:hetman_boxing_club/core/widgets/section_header.dart';
import 'package:hetman_boxing_club/features/news/presentation/view_model/news_view_model.dart';

class NewsPage extends ConsumerWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(newsViewModelProvider);
    return ClubScrollView(
      children: [
        const SectionHeader(title: 'AKTUALNOŚCI'),
        const SizedBox(height: 18),
        for (var i = 0; i < posts.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: ClubCard(
              onTap: () => context.go(AppRoutes.newsPost(posts[i].id)),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final stacked = constraints.maxWidth < 680;
                  final image = AspectRatio(
                    aspectRatio: stacked ? 16 / 8 : 1,
                    child: ClubPhoto(url: posts[i].imageUrl),
                  );
                  final copy = Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ClubDate.short(posts[i].date), style: AppTypography.label(color: AppColors.redBright)),
                        const SizedBox(height: 8),
                        Text(posts[i].title, style: AppTypography.display(28, style: FontStyle.normal)),
                        const SizedBox(height: 8),
                        Text(posts[i].excerpt, style: AppTypography.body(size: 14)),
                      ],
                    ),
                  );
                  if (stacked) {
                    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [image, copy]);
                  }
                  return Row(
                    children: [
                      SizedBox(width: 220, height: 150, child: image),
                      Expanded(child: copy),
                    ],
                  );
                },
              ),
            ).animate(delay: (50 * i).ms).fadeIn(duration: 300.ms),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hetman_boxing_club/app/router/app_routes.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';
import 'package:hetman_boxing_club/app/theme/app_typography.dart';
import 'package:hetman_boxing_club/core/widgets/club_photo.dart';
import 'package:hetman_boxing_club/core/widgets/club_scroll_view.dart';
import 'package:hetman_boxing_club/core/widgets/hetman_button.dart';
import 'package:hetman_boxing_club/features/about/presentation/view_model/about_view_model.dart';
import 'package:hetman_boxing_club/features/club/domain/club_domain.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final about = ref.watch(aboutViewModelProvider);
    return ClubScrollView(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 800;
            final intro = [
              for (final paragraph in about.intro)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    paragraph,
                    style: AppTypography.body(size: 16, color: AppColors.textPrimary, height: 1.6),
                  ),
                ),
            ];
            final photo = ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: ClubPhoto(asset: about.imageAsset),
              ),
            );
            final heading = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(about.title, style: AppTypography.label(size: 14, color: AppColors.redBright, spacing: 1.6)),
                const SizedBox(height: 8),
                Text(about.headline, style: AppTypography.display(wide ? 44 : 34)),
                const SizedBox(height: 16),
              ],
            );
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (wide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 6, child: photo),
                      const SizedBox(width: 28),
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [heading, ...intro],
                        ),
                      ),
                    ],
                  )
                else ...[
                  photo,
                  const SizedBox(height: 18),
                  heading,
                  ...intro,
                ],
                for (final block in about.blocks) _AboutBlockView(block: block, wide: wide),
                const SizedBox(height: 8),
                Text(about.slogan, style: AppTypography.display(wide ? 28 : 22)),
                for (final line in about.closing) ...[
                  const SizedBox(height: 12),
                  Text(
                    line,
                    style: AppTypography.body(size: 16, color: AppColors.textPrimary, height: 1.6),
                  ),
                ],
                const SizedBox(height: 20),
                HetmanButton(
                  label: 'DOŁĄCZ PRZEZ WHATSAPP',
                  icon: Icons.arrow_forward,
                  onPressed: () => context.go(AppRoutes.enroll),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _AboutBlockView extends StatelessWidget {
  const _AboutBlockView({required this.block, required this.wide});

  final AboutBlock block;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final columns = wide && block.points.length >= 4 ? 2 : 1;
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(block.heading, style: AppTypography.display(wide ? 32 : 26)),
          const SizedBox(height: 12),
          if (block.points.isNotEmpty)
            LayoutBuilder(
              builder: (context, constraints) {
                final gap = 12.0;
                final itemWidth = columns == 1 ? constraints.maxWidth : ((constraints.maxWidth - gap) / 2) - 1;
                return Wrap(
                  spacing: gap,
                  runSpacing: 10,
                  children: [
                    for (final point in block.points)
                      SizedBox(width: itemWidth, child: _Point(text: point)),
                  ],
                );
              },
            ),
          for (final paragraph in block.paragraphs) ...[
            const SizedBox(height: 10),
            Text(paragraph, style: AppTypography.body(size: 16, color: AppColors.textPrimary, height: 1.6)),
          ],
        ],
      ),
    );
  }
}

class _Point extends StatelessWidget {
  const _Point({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final parts = text.split(' — ');
    final style = AppTypography.body(size: 15, color: AppColors.textPrimary, height: 1.45);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(color: AppColors.red, shape: BoxShape.circle),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: parts.length == 2
              ? Text.rich(
                  TextSpan(
                    style: style,
                    children: [
                      TextSpan(text: parts[0], style: const TextStyle(fontWeight: FontWeight.w700)),
                      TextSpan(text: ' — ${parts[1]}'),
                    ],
                  ),
                )
              : Text(text, style: style),
        ),
      ],
    );
  }
}

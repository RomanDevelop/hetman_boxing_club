import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hetman_boxing_club/app/router/app_routes.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';
import 'package:hetman_boxing_club/app/theme/app_typography.dart';
import 'package:hetman_boxing_club/core/widgets/club_card.dart';
import 'package:hetman_boxing_club/core/widgets/club_photo.dart';
import 'package:hetman_boxing_club/core/widgets/hetman_button.dart';
import 'package:hetman_boxing_club/core/widgets/section_header.dart';
import 'package:hetman_boxing_club/features/club/domain/club_domain.dart';
import 'package:hetman_boxing_club/features/gallery/presentation/view_model/gallery_view_model.dart';

class GallerySection extends ConsumerWidget {
  const GallerySection({this.preview = false, super.key});

  final bool preview;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(galleryViewModelProvider);
    final items = preview ? state.items.take(4).toList() : state.visible;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: preview ? 'ZOBACZ NASZĄ GALERIĘ' : 'GALERIA',
          actionLabel: preview ? 'WSZYSTKIE ZDJĘCIA' : null,
          onAction: preview ? () => context.go(AppRoutes.gallery) : null,
        ),
        const SizedBox(height: 16),
        if (!preview)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final category in state.categories)
                  ChoiceChip(
                    label: Text(category),
                    selected: state.category == category,
                    onSelected: (_) => ref.read(galleryViewModelProvider.notifier).selectCategory(category),
                    selectedColor: AppColors.red,
                    labelStyle: AppTypography.body(
                      size: 13,
                      color: state.category == category ? Colors.white : AppColors.textSecondary,
                    ),
                    backgroundColor: AppColors.surface,
                    side: const BorderSide(color: AppColors.line),
                  ),
              ],
            ),
          ),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = preview
                ? (constraints.maxWidth >= 1000 ? 4 : constraints.maxWidth >= 680 ? 2 : 1)
                : (constraints.maxWidth >= 900 ? 3 : constraints.maxWidth >= 560 ? 2 : 1);
            final gap = preview ? 16.0 : 12.0;
            final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
            final imageAspect = preview && columns >= 4 ? width / (width * 10 / 16 + 143) : 16 / 10;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (var i = 0; i < items.length; i++)
                  SizedBox(
                    width: width,
                    child: _GalleryTile(item: items[i], imageAspect: imageAspect)
                        .animate(delay: (40 * i).ms)
                        .fadeIn(duration: 300.ms),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _GalleryTile extends StatelessWidget {
  const _GalleryTile({required this.item, this.imageAspect = 16 / 10});

  final GalleryItem item;
  final double imageAspect;

  @override
  Widget build(BuildContext context) {
    return ClubCard(
      onTap: () => showDialog<void>(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: AppColors.surface,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(aspectRatio: 16 / 10, child: ClubPhoto(url: item.imageUrl)),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.category, style: AppTypography.label(color: AppColors.redBright)),
                      const SizedBox(height: 6),
                      Text(item.title, style: AppTypography.display(32, style: FontStyle.normal)),
                      const SizedBox(height: 12),
                      HetmanButton(label: 'ZAMKNIJ', onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(aspectRatio: imageAspect, child: ClubPhoto(url: item.imageUrl)),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.category, style: AppTypography.label(size: 11, color: AppColors.redBright)),
                Text(item.title, style: AppTypography.title(18)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

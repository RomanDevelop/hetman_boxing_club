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
import 'package:hetman_boxing_club/features/club/domain/club_domain.dart';
import 'package:hetman_boxing_club/features/training/presentation/view_model/training_view_model.dart';

class TrainingSection extends ConsumerWidget {
  const TrainingSection({this.showDiscipline = true, super.key});

  final bool showDiscipline;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offer = ref.watch(trainingViewModelProvider);
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 980;
        final photo = _OfferPhoto(title: offer.title, body: offer.body, imageUrl: offer.imageUrl);
        final benefits = _BenefitList(items: offer.benefits);
        final quote = _QuoteCard(quote: offer.quote);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (wide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: photo),
                  const SizedBox(width: 18),
                  Expanded(flex: 3, child: benefits),
                  const SizedBox(width: 18),
                  Expanded(flex: 4, child: quote),
                ],
              )
            else ...[
              photo,
              const SizedBox(height: 16),
              benefits,
              const SizedBox(height: 16),
              quote,
            ],
            if (showDiscipline) ...[
              const SizedBox(height: 28),
              _DisciplineBanner(text: offer.discipline),
            ],
            const SizedBox(height: 18),
            Align(
              alignment: Alignment.centerLeft,
              child: HetmanButton(
                label: 'ZAPISZ SIĘ TERAZ',
                icon: Icons.arrow_forward,
                expanded: !wide,
                onPressed: () => context.go(AppRoutes.enroll),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _OfferPhoto extends StatelessWidget {
  const _OfferPhoto({required this.title, required this.body, required this.imageUrl});

  final String title;
  final String body;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        height: 360,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClubPhoto(url: imageUrl),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x22000000), Color(0xE6070708)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(title, style: AppTypography.display(48)),
                  const SizedBox(height: 8),
                  Container(width: 72, height: 4, color: AppColors.red),
                  const SizedBox(height: 12),
                  Text(body, style: AppTypography.body(size: 14, color: AppColors.textPrimary)),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}

class _BenefitList extends StatelessWidget {
  const _BenefitList({required this.items});

  final List<TrainingBenefit> items;

  @override
  Widget build(BuildContext context) {
    return ClubCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          for (final item in items)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: AppColors.red, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item.title,
                      style: AppTypography.body(size: 15, color: AppColors.textPrimary),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _QuoteCard extends StatelessWidget {
  const _QuoteCard({required this.quote});

  final String quote;

  @override
  Widget build(BuildContext context) {
    return ClubCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('“', style: AppTypography.display(64, color: AppColors.red)),
          Text(quote, style: AppTypography.body(size: 18, color: AppColors.textPrimary, height: 1.4)),
          const SizedBox(height: 18),
          const Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.sports_mma, color: AppColors.red, size: 42),
          ),
        ],
      ),
    );
  }
}

class _DisciplineBanner extends StatelessWidget {
  const _DisciplineBanner({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        height: 280,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2A070B), Color(0xFF070708)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('♛', style: TextStyle(color: AppColors.red, fontSize: 28)),
                  const SizedBox(height: 8),
                  Text(text, style: AppTypography.display(42)),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 450.ms);
  }
}

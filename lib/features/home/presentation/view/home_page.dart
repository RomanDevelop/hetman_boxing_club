import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hetman_boxing_club/app/router/app_routes.dart';
import 'package:hetman_boxing_club/core/layout/breakpoints.dart';
import 'package:hetman_boxing_club/core/widgets/club_scroll_view.dart';
import 'package:hetman_boxing_club/core/widgets/hetman_button.dart';
import 'package:hetman_boxing_club/features/achievements/presentation/widgets/achievements_section.dart';
import 'package:hetman_boxing_club/features/contact/presentation/widgets/site_footer.dart';
import 'package:hetman_boxing_club/features/gallery/presentation/widgets/gallery_section.dart';
import 'package:hetman_boxing_club/features/groups/presentation/widgets/groups_section.dart';
import 'package:hetman_boxing_club/features/home/presentation/widgets/features_strip.dart';
import 'package:hetman_boxing_club/features/home/presentation/widgets/hero_section.dart';
import 'package:hetman_boxing_club/features/schedule/presentation/widgets/schedule_section.dart';
import 'package:hetman_boxing_club/features/trainers/presentation/widgets/trainers_section.dart';
import 'package:hetman_boxing_club/features/training/presentation/widgets/training_section.dart';

class DesktopLanding extends StatelessWidget {
  const DesktopLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: HeroSection()),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(28, 8, 28, 36),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1180),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FeaturesStrip(),
                    SizedBox(height: 56),
                    GroupsSection(),
                    SizedBox(height: 56),
                    TrainingSection(showDiscipline: false),
                    SizedBox(height: 56),
                    _Split(
                      left: ScheduleSection(),
                      right: TrainersSection(),
                    ),
                    SizedBox(height: 56),
                    _Split(
                      left: GallerySection(preview: true),
                      right: AchievementsSection(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: SiteFooter()),
      ],
    );
  }
}

class _Split extends StatelessWidget {
  const _Split({required this.left, required this.right});

  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < Breakpoints.desktop) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              left,
              const SizedBox(height: 36),
              right,
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 6, child: left),
            const SizedBox(width: 28),
            Expanded(flex: 5, child: right),
          ],
        );
      },
    );
  }
}

class MobileHome extends StatelessWidget {
  const MobileHome({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final available = constraints.maxHeight.isFinite ? constraints.maxHeight : 680.0;
        final height = available < 640 ? 680.0 : available;
        if (available < 640) {
          return SingleChildScrollView(child: SizedBox(height: height, child: const HeroSection()));
        }
        return const HeroSection();
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (Breakpoints.isDesktop(constraints.maxWidth)) {
          return const DesktopLanding();
        }
        return const MobileHome();
      },
    );
  }
}

class NotFoundBody extends StatelessWidget {
  const NotFoundBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ClubScrollView(
      children: [
        const Text('Nie znaleziono strony.'),
        const SizedBox(height: 16),
        HetmanButton(label: 'STRONA GŁÓWNA', onPressed: () => context.go(AppRoutes.home)),
      ],
    );
  }
}

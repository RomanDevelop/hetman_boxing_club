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
import 'package:hetman_boxing_club/features/home/presentation/widgets/team_banner.dart';
import 'package:hetman_boxing_club/features/schedule/presentation/widgets/schedule_section.dart';
import 'package:hetman_boxing_club/features/trainers/presentation/widgets/trainers_section.dart';
import 'package:hetman_boxing_club/features/training/presentation/widgets/training_section.dart';

class DesktopLanding extends StatelessWidget {
  const DesktopLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: TeamBanner()),
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
                    ScheduleSection(),
                    SizedBox(height: 56),
                    TrainersSection(),
                    SizedBox(height: 56),
                    GallerySection(preview: true),
                    SizedBox(height: 56),
                    AchievementsSection(),
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

class MobileHome extends StatelessWidget {
  const MobileHome({required this.viewportHeight, super.key});

  final double viewportHeight;

  @override
  Widget build(BuildContext context) {
    final heroHeight = viewportHeight.isFinite && viewportHeight > 0 ? viewportHeight : 680.0;
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: TeamBanner()),
        SliverToBoxAdapter(
          child: SizedBox(height: heroHeight, child: const HeroSection()),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FeaturesStrip(),
                SizedBox(height: 40),
                GroupsSection(),
                SizedBox(height: 40),
                TrainingSection(showDiscipline: false),
                SizedBox(height: 40),
                ScheduleSection(),
                SizedBox(height: 40),
                TrainersSection(),
                SizedBox(height: 40),
                GallerySection(preview: true),
                SizedBox(height: 40),
                AchievementsSection(),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SiteFooter()),
      ],
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
        return MobileHome(viewportHeight: constraints.maxHeight);
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

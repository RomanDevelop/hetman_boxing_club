import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hetman_boxing_club/app/router/app_routes.dart';
import 'package:hetman_boxing_club/features/about/presentation/view/about_page.dart';
import 'package:hetman_boxing_club/features/achievements/presentation/view/achievements_page.dart';
import 'package:hetman_boxing_club/features/athletes/presentation/view/athletes_page.dart';
import 'package:hetman_boxing_club/features/contact/presentation/view/contact_page.dart';
import 'package:hetman_boxing_club/features/enrollment/presentation/view/enrollment_page.dart';
import 'package:hetman_boxing_club/features/gallery/presentation/view/gallery_page.dart';
import 'package:hetman_boxing_club/features/groups/presentation/view/groups_page.dart';
import 'package:hetman_boxing_club/features/home/presentation/view/home_page.dart';
import 'package:hetman_boxing_club/features/news/presentation/view/news_detail_page.dart';
import 'package:hetman_boxing_club/features/news/presentation/view/news_page.dart';
import 'package:hetman_boxing_club/features/schedule/presentation/view/schedule_page.dart';
import 'package:hetman_boxing_club/features/shell/presentation/view/app_shell.dart';
import 'package:hetman_boxing_club/features/trainers/presentation/view/trainers_page.dart';
import 'package:hetman_boxing_club/features/training/presentation/view/training_page.dart';

CustomTransitionPage<void> _fadePage({required LocalKey key, required Widget child}) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    transitionDuration: const Duration(milliseconds: 280),
    reverseTransitionDuration: const Duration(milliseconds: 220),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 0.02), end: Offset.zero).animate(curved),
          child: child,
        ),
      );
    },
  );
}

GoRouter buildRouter() {
  return GoRouter(
    initialLocation: AppRoutes.home,
    errorBuilder: (context, state) => const AppShell(child: NotFoundBody()),
    routes: [
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            pageBuilder: (context, state) => _fadePage(key: state.pageKey, child: const HomePage()),
          ),
          GoRoute(
            path: AppRoutes.about,
            pageBuilder: (context, state) => _fadePage(key: state.pageKey, child: const AboutPage()),
          ),
          GoRoute(
            path: AppRoutes.training,
            pageBuilder: (context, state) => _fadePage(key: state.pageKey, child: const TrainingPage()),
          ),
          GoRoute(
            path: AppRoutes.groups,
            pageBuilder: (context, state) => _fadePage(key: state.pageKey, child: const GroupsPage()),
          ),
          GoRoute(
            path: AppRoutes.trainers,
            pageBuilder: (context, state) => _fadePage(key: state.pageKey, child: const TrainersPage()),
          ),
          GoRoute(
            path: AppRoutes.athletes,
            pageBuilder: (context, state) => _fadePage(key: state.pageKey, child: const AthletesPage()),
          ),
          GoRoute(
            path: AppRoutes.schedule,
            pageBuilder: (context, state) => _fadePage(key: state.pageKey, child: const SchedulePage()),
          ),
          GoRoute(
            path: AppRoutes.gallery,
            pageBuilder: (context, state) => _fadePage(key: state.pageKey, child: const GalleryPage()),
          ),
          GoRoute(
            path: AppRoutes.contact,
            pageBuilder: (context, state) => _fadePage(key: state.pageKey, child: const ContactPage()),
          ),
          GoRoute(
            path: AppRoutes.achievements,
            pageBuilder: (context, state) => _fadePage(key: state.pageKey, child: const AchievementsPage()),
          ),
          GoRoute(
            path: AppRoutes.enroll,
            pageBuilder: (context, state) => _fadePage(
              key: state.pageKey,
              child: EnrollmentPage(initialGroupId: state.uri.queryParameters['grupa']),
            ),
          ),
          GoRoute(
            path: AppRoutes.news,
            pageBuilder: (context, state) => _fadePage(key: state.pageKey, child: const NewsPage()),
            routes: [
              GoRoute(
                path: ':id',
                pageBuilder: (context, state) => _fadePage(
                  key: state.pageKey,
                  child: NewsDetailPage(postId: state.pathParameters['id']!),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hetman_boxing_club/app/router/app_routes.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';
import 'package:hetman_boxing_club/app/theme/app_typography.dart';
import 'package:hetman_boxing_club/core/layout/breakpoints.dart';
import 'package:hetman_boxing_club/core/widgets/club_atmosphere.dart';
import 'package:hetman_boxing_club/core/widgets/hetman_button.dart';
import 'package:hetman_boxing_club/core/widgets/hetman_logo.dart';

class ClubDestination {
  const ClubDestination(this.label, this.path, this.icon);

  final String label;
  final String path;
  final IconData icon;
}

const clubMenu = <ClubDestination>[
  ClubDestination('Strona główna', AppRoutes.home, Icons.home_outlined),
  ClubDestination('O klubie', AppRoutes.about, Icons.info_outline),
  ClubDestination('Treningi', AppRoutes.training, Icons.sports_mma_outlined),
  ClubDestination('Trenerzy', AppRoutes.trainers, Icons.groups_outlined),
  ClubDestination('Zawodnicy', AppRoutes.athletes, Icons.emoji_events_outlined),
  ClubDestination('Grafik', AppRoutes.schedule, Icons.calendar_month_outlined),
  ClubDestination('Aktualności', AppRoutes.news, Icons.article_outlined),
  ClubDestination('Galeria', AppRoutes.gallery, Icons.photo_library_outlined),
  ClubDestination('Kontakt', AppRoutes.contact, Icons.mail_outline),
];

const desktopLinks = <ClubDestination>[
  ClubDestination('O klubie', AppRoutes.about, Icons.info_outline),
  ClubDestination('Trening', AppRoutes.training, Icons.sports_mma_outlined),
  ClubDestination('Trenerzy', AppRoutes.trainers, Icons.groups_outlined),
  ClubDestination('Zawodnicy', AppRoutes.athletes, Icons.emoji_events_outlined),
  ClubDestination('Grafik', AppRoutes.schedule, Icons.calendar_month_outlined),
  ClubDestination('Aktualności', AppRoutes.news, Icons.article_outlined),
  ClubDestination('Galeria', AppRoutes.gallery, Icons.photo_library_outlined),
  ClubDestination('Kontakt', AppRoutes.contact, Icons.mail_outline),
];

bool routeIsActive(String location, String path) {
  if (path == AppRoutes.home) return location == AppRoutes.home;
  return location == path || location.startsWith('$path/');
}

class AppShell extends StatefulWidget {
  const AppShell({required this.child, super.key});

  final Widget child;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openMenu() => _scaffoldKey.currentState?.openEndDrawer();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: GoRouter.of(context).routerDelegate,
      builder: (context, _) {
        final location = GoRouterState.of(context).uri.path;
        final wide = MediaQuery.sizeOf(context).width >= Breakpoints.desktop;
        final fullNav = MediaQuery.sizeOf(context).width >= 1280;

        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: AppColors.background,
          endDrawer: Drawer(
            width: wide ? 380 : MediaQuery.sizeOf(context).width,
            backgroundColor: AppColors.background,
            shape: const RoundedRectangleBorder(),
            child: _ClubMenu(
              location: location,
              onClose: () => Navigator.pop(context),
            ),
          ),
          body: Stack(
            children: [
              const Positioned.fill(child: ClubAtmosphere()),
              Positioned.fill(
                child: Column(
                  children: [
                    if (wide)
                      _DesktopBar(location: location, fullNav: fullNav, onMenu: _openMenu)
                    else
                      _MobileBar(onMenu: _openMenu),
                    Expanded(child: widget.child),
                    if (!wide) _BottomNav(location: location),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DesktopBar extends StatelessWidget {
  const _DesktopBar({required this.location, required this.fullNav, required this.onMenu});

  final String location;
  final bool fullNav;
  final VoidCallback onMenu;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.72),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: [
              const HetmanLogo(),
              const SizedBox(width: 18),
              if (fullNav)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      for (final link in desktopLinks)
                        _NavLink(
                          label: link.label,
                          active: routeIsActive(location, link.path),
                          onTap: () => context.go(link.path),
                        ),
                    ],
                  ),
                )
              else
                const Spacer(),
              const SizedBox(width: 8),
              HetmanButton(
                label: 'ZAPISZ SIĘ',
                icon: Icons.arrow_forward,
                onPressed: () => context.go(AppRoutes.enroll),
              ),
              IconButton(tooltip: 'Menu', onPressed: onMenu, icon: const Icon(Icons.menu)),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({required this.label, required this.active, required this.onTap});

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTypography.body(
                size: 14,
                weight: FontWeight.w700,
                color: active ? Colors.white : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              height: 2,
              width: active ? 18 : 0,
              color: AppColors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileBar extends StatelessWidget {
  const _MobileBar({required this.onMenu});

  final VoidCallback onMenu;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.55),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              const HetmanLogo(compact: true),
              const Spacer(),
              IconButton(tooltip: 'Menu', onPressed: onMenu, icon: const Icon(Icons.menu)),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.location});

  final String location;

  static const _items = <(String, String, IconData)>[
    ('TRENING', AppRoutes.home, Icons.sports_mma),
    ('TRENERZY', AppRoutes.trainers, Icons.groups_outlined),
    ('GRAFIK', AppRoutes.schedule, Icons.calendar_month_outlined),
    ('KONTAKT', AppRoutes.contact, Icons.place_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF0C0C0E),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              for (final item in _items)
                Expanded(
                  child: InkWell(
                    onTap: () => context.go(item.$2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.$3,
                          color: routeIsActive(location, item.$2) ? AppColors.redBright : AppColors.textMuted,
                          size: 22,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.$1,
                          style: AppTypography.label(
                            size: 10,
                            color: routeIsActive(location, item.$2) ? AppColors.redBright : AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClubMenu extends StatelessWidget {
  const _ClubMenu({required this.location, required this.onClose});

  final String location;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Expanded(child: HetmanLogo(compact: true)),
                IconButton(onPressed: onClose, icon: const Icon(Icons.close)),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: [
                  for (final item in clubMenu)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        tileColor: routeIsActive(location, item.path) ? AppColors.red : Colors.transparent,
                        leading: Icon(item.icon),
                        title: Text(item.label, style: AppTypography.body(size: 16, color: Colors.white, weight: FontWeight.w700)),
                        onTap: () {
                          onClose();
                          context.go(item.path);
                        },
                      ),
                    ),
                ],
              ),
            ),
            HetmanButton(
              label: 'ZAPISZ SIĘ NA DARMOWY TRENING',
              icon: Icons.arrow_forward,
              expanded: true,
              onPressed: () {
                onClose();
                context.go(AppRoutes.enroll);
              },
            ),
          ],
        ),
      ),
    );
  }
}

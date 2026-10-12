import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hetman_boxing_club/app/router/app_routes.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';
import 'package:hetman_boxing_club/app/theme/app_typography.dart';
import 'package:hetman_boxing_club/core/navigation/open_club_link.dart';
import 'package:hetman_boxing_club/core/widgets/hetman_button.dart';
import 'package:hetman_boxing_club/core/widgets/hetman_logo.dart';
import 'package:hetman_boxing_club/features/contact/presentation/view_model/contact_view_model.dart';

class SiteFooter extends ConsumerWidget {
  const SiteFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contact = ref.watch(contactViewModelProvider);
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(contact.city, style: AppTypography.title(18)),
        const SizedBox(height: 2),
        Text(
          contact.venue,
          style: AppTypography.body(size: 14, color: AppColors.textPrimary),
        ),
        Text(contact.street, style: AppTypography.body(size: 14)),
        const SizedBox(height: 8),
        _FooterLink(
          icon: Icons.phone_outlined,
          label: contact.phoneDisplay,
          onTap:
              () => openClubLink(
                ref,
                context,
                Uri.parse('tel:${contact.phoneUri}'),
              ),
        ),
        const SizedBox(height: 4),
        _FooterLink(
          icon: Icons.mail_outline,
          label: contact.email,
          onTap:
              () => openClubLink(
                ref,
                context,
                Uri.parse('mailto:${contact.email}'),
              ),
        ),
      ],
    );
    final socials = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SocialButton(
          icon: Icons.facebook,
          tooltip: 'Facebook',
          onPressed:
              () => openClubLink(ref, context, Uri.parse(contact.facebookUrl)),
        ),
        const SizedBox(width: 8),
        const _SocialButton(icon: Icons.camera_alt_outlined),
        const SizedBox(width: 8),
        const _SocialButton(icon: Icons.play_circle_outline),
      ],
    );

    return Container(
      width: double.infinity,
      color: const Color(0xFF050506),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 980;
              final logo = InkWell(
                onTap: () => context.go(AppRoutes.home),
                borderRadius: BorderRadius.circular(12),
                child: ClubEmblem(size: wide ? 64 : 56),
              );
              final button = HetmanButton(
                label: 'DOŁĄCZ PRZEZ WHATSAPP',
                icon: Icons.arrow_forward,
                expanded: !wide,
                onPressed: () => context.go(AppRoutes.enroll),
              );

              if (!wide) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(alignment: Alignment.centerLeft, child: logo),
                    const SizedBox(height: 16),
                    details,
                    const SizedBox(height: 14),
                    Align(alignment: Alignment.centerLeft, child: socials),
                    const SizedBox(height: 18),
                    button,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  logo,
                  const SizedBox(width: 22),
                  details,
                  const Spacer(),
                  socials,
                  const SizedBox(width: 20),
                  button,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColors.redBright),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTypography.body(size: 14, color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.icon, this.onPressed, this.tooltip});

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      tooltip: tooltip,
      onPressed:
          onPressed ??
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profil społecznościowy pojawi się wkrótce.'),
              ),
            );
          },
      icon: Icon(icon, size: 18),
    );
  }
}

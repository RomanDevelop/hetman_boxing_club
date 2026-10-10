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
    return Container(
      width: double.infinity,
      color: const Color(0xFF050506),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 24,
            runSpacing: 20,
            children: [
              const HetmanLogo(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(contact.city, style: AppTypography.title(18)),
                  Text(contact.street, style: AppTypography.body(size: 14)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FooterLink(
                    icon: Icons.phone_outlined,
                    label: contact.phoneDisplay,
                    onTap: () => openClubLink(ref, context, Uri.parse('tel:${contact.phoneUri}')),
                  ),
                  const SizedBox(height: 6),
                  _FooterLink(
                    icon: Icons.mail_outline,
                    label: contact.email,
                    onTap: () => openClubLink(ref, context, Uri.parse('mailto:${contact.email}')),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  _SocialButton(icon: Icons.facebook),
                  SizedBox(width: 8),
                  _SocialButton(icon: Icons.camera_alt_outlined),
                  SizedBox(width: 8),
                  _SocialButton(icon: Icons.play_circle_outline),
                ],
              ),
              HetmanButton(
                label: 'DOŁĄCZ DO KLUBU',
                icon: Icons.arrow_forward,
                onPressed: () => context.go(AppRoutes.enroll),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.icon, required this.label, required this.onTap});

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
            Text(label, style: AppTypography.body(size: 14, color: AppColors.textPrimary)),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil społecznościowy pojawi się wkrótce.')),
        );
      },
      icon: Icon(icon, size: 18),
    );
  }
}

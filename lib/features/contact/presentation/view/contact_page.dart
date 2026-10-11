import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hetman_boxing_club/app/router/app_routes.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';
import 'package:hetman_boxing_club/app/theme/app_typography.dart';
import 'package:hetman_boxing_club/core/navigation/open_club_link.dart';
import 'package:hetman_boxing_club/core/widgets/club_card.dart';
import 'package:hetman_boxing_club/core/widgets/club_scroll_view.dart';
import 'package:hetman_boxing_club/core/widgets/hetman_button.dart';
import 'package:hetman_boxing_club/core/widgets/section_header.dart';
import 'package:hetman_boxing_club/features/contact/presentation/view_model/contact_view_model.dart';

class ContactPage extends ConsumerWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contact = ref.watch(contactViewModelProvider);
    return ClubScrollView(
      children: [
        const SectionHeader(title: 'KONTAKT'),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 800;
            final details = Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(contact.city, style: AppTypography.display(36, style: FontStyle.normal)),
                Text(contact.street, style: AppTypography.body(size: 16, color: AppColors.textPrimary)),
                const SizedBox(height: 16),
                _ContactRow(
                  icon: Icons.phone_outlined,
                  label: contact.phoneDisplay,
                  onTap: () => openClubLink(ref, context, Uri.parse('tel:${contact.phoneUri}')),
                ),
                const SizedBox(height: 10),
                _ContactRow(
                  icon: Icons.mail_outline,
                  label: contact.email,
                  onTap: () => openClubLink(ref, context, Uri.parse('mailto:${contact.email}')),
                ),
                const SizedBox(height: 12),
                HetmanButton(
                  label: 'OTWÓRZ W GOOGLE MAPS',
                  icon: Icons.map_outlined,
                  variant: HetmanButtonVariant.outline,
                  onPressed: () => openClubLink(
                    ref,
                    context,
                    Uri.parse(
                      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(contact.mapQuery)}',
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                HetmanButton(
                  label: 'ZAPISZ SIĘ PRZEZ WHATSAPP',
                  icon: Icons.arrow_forward,
                  onPressed: () => context.go(AppRoutes.enroll),
                ),
              ],
            );

            if (!wide) {
              return Column(
                children: [
                  const _ClubMap(),
                  const SizedBox(height: 16),
                  details,
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: _ClubMap()),
                const SizedBox(width: 20),
                Expanded(child: details),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClubCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: AppColors.redBright),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: AppTypography.body(size: 16, color: AppColors.textPrimary))),
        ],
      ),
    );
  }
}

class _ClubMap extends StatelessWidget {
  const _ClubMap();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        height: 280,
        child: CustomPaint(
          painter: _MapPainter(),
          child: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on, color: AppColors.redBright, size: 42),
                SizedBox(height: 6),
                Text('HETMAN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()..color = const Color(0xFF14161C);
    canvas.drawRect(Offset.zero & size, background);

    final road = Paint()
      ..color = const Color(0xFF2C3140)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(0, size.height * 0.35), Offset(size.width, size.height * 0.48), road);
    canvas.drawLine(Offset(size.width * 0.3, 0), Offset(size.width * 0.55, size.height), road);

    final thin = Paint()
      ..color = const Color(0xFF232838)
      ..strokeWidth = 1;
    for (var i = 0; i < 8; i++) {
      final y = size.height / 8 * i;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), thin);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

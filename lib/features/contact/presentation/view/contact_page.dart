import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
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
import 'package:hetman_boxing_club/features/club/domain/club_domain.dart';
import 'package:hetman_boxing_club/features/contact/presentation/view_model/contact_view_model.dart';
import 'package:latlong2/latlong.dart';

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
                Text(
                  contact.city,
                  style: AppTypography.display(36, style: FontStyle.normal),
                ),
                Text(
                  contact.venue,
                  style: AppTypography.body(
                    size: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  contact.street,
                  style: AppTypography.body(
                    size: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                _ContactRow(
                  icon: Icons.phone_outlined,
                  label: contact.phoneDisplay,
                  onTap:
                      () => openClubLink(
                        ref,
                        context,
                        Uri.parse('tel:${contact.phoneUri}'),
                      ),
                ),
                const SizedBox(height: 10),
                _ContactRow(
                  icon: Icons.mail_outline,
                  label: contact.email,
                  onTap:
                      () => openClubLink(
                        ref,
                        context,
                        Uri.parse('mailto:${contact.email}'),
                      ),
                ),
                const SizedBox(height: 12),
                HetmanButton(
                  label: 'OTWÓRZ W GOOGLE MAPS',
                  icon: Icons.map_outlined,
                  variant: HetmanButtonVariant.outline,
                  onPressed:
                      () => openClubLink(
                        ref,
                        context,
                        Uri.https('www.google.com', '/maps/search/', {
                          'api': '1',
                          'query': '${contact.latitude},${contact.longitude}',
                        }),
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

            final map = _ClubMap(contact: contact, height: wide ? 460 : 320);
            if (!wide) {
              return Column(
                children: [map, const SizedBox(height: 16), details],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: map),
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
  const _ContactRow({
    required this.icon,
    required this.label,
    required this.onTap,
  });

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
          Expanded(
            child: Text(
              label,
              style: AppTypography.body(size: 16, color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClubMap extends StatelessWidget {
  const _ClubMap({required this.contact, required this.height});

  final ContactDetails contact;
  final double height;

  @override
  Widget build(BuildContext context) {
    final point = LatLng(contact.latitude, contact.longitude);
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        height: height,
        child: FlutterMap(
          options: MapOptions(
            initialCenter: point,
            initialZoom: 17,
            minZoom: 14,
            maxZoom: 19,
            backgroundColor: const Color(0xFF14161C),
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'pl.asbks.hetman.hetman_boxing_club',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: point,
                  width: 44,
                  height: 44,
                  alignment: Alignment.topCenter,
                  child: const Icon(
                    Icons.location_on,
                    color: AppColors.redBright,
                    size: 44,
                  ),
                ),
              ],
            ),
            const SimpleAttributionWidget(
              alignment: Alignment.topRight,
              source: Text('OpenStreetMap'),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 280),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0xF0070708),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('HETMAN', style: AppTypography.title(16)),
                          Text(
                            contact.mapQuery,
                            style: AppTypography.body(
                              size: 12,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

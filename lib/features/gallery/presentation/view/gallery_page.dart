import 'package:flutter/material.dart';
import 'package:hetman_boxing_club/core/widgets/club_scroll_view.dart';
import 'package:hetman_boxing_club/features/gallery/presentation/widgets/gallery_section.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClubScrollView(children: [GallerySection()]);
  }
}

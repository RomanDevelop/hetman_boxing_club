import 'package:flutter/material.dart';
import 'package:hetman_boxing_club/core/layout/breakpoints.dart';
import 'package:hetman_boxing_club/features/contact/presentation/widgets/site_footer.dart';

class ClubScrollView extends StatelessWidget {
  const ClubScrollView({
    required this.children,
    this.footer = true,
    super.key,
  });

  final List<Widget> children;
  final bool footer;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final wide = Breakpoints.isDesktop(width);
    final horizontal = wide ? 28.0 : 16.0;

    return CustomScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(horizontal, 12, horizontal, 28),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1180),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children,
                ),
              ),
            ),
          ),
        ),
        if (footer && wide) const SliverToBoxAdapter(child: SiteFooter()),
      ],
    );
  }
}

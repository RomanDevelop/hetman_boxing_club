import 'package:flutter/material.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';

class ClubCard extends StatefulWidget {
  const ClubCard({
    required this.child,
    this.onTap,
    this.padding,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  State<ClubCard> createState() => _ClubCardState();
}

class _ClubCardState extends State<ClubCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: widget.onTap == null ? MouseCursor.defer : SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        clipBehavior: Clip.antiAlias,
        transform: Matrix4.translationValues(0, _hover && widget.onTap != null ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _hover && widget.onTap != null
                ? AppColors.red.withValues(alpha: 0.75)
                : Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            child: widget.padding == null
                ? widget.child
                : Padding(padding: widget.padding!, child: widget.child),
          ),
        ),
      ),
    );
  }
}

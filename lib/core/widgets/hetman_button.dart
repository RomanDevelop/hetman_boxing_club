import 'package:flutter/material.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';
import 'package:hetman_boxing_club/app/theme/app_typography.dart';

enum HetmanButtonVariant { filled, outline, text }

class HetmanButton extends StatefulWidget {
  const HetmanButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.leading,
    this.expanded = false,
    this.variant = HetmanButtonVariant.filled,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final IconData? leading;
  final bool expanded;
  final HetmanButtonVariant variant;

  @override
  State<HetmanButton> createState() => _HetmanButtonState();
}

class _HetmanButtonState extends State<HetmanButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final filled = widget.variant == HetmanButtonVariant.filled;
    final text = widget.variant == HetmanButtonVariant.text;
    final foreground = text ? AppColors.redBright : Colors.white;
    final background = filled
        ? (_hover ? AppColors.redBright : AppColors.red)
        : Colors.transparent;

    final button = MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(999),
          border: text
              ? null
              : Border.all(
                  color: filled ? Colors.transparent : Colors.white.withValues(alpha: 0.75),
                ),
          boxShadow: filled
              ? [
                  BoxShadow(
                    color: AppColors.red.withValues(alpha: _hover ? 0.45 : 0.28),
                    blurRadius: _hover ? 22 : 14,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: widget.onPressed,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: text ? 4 : 18, vertical: text ? 8 : 14),
              child: Row(
                mainAxisSize: widget.expanded ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.leading != null) ...[
                    Icon(widget.leading, size: 18, color: foreground),
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Text(
                      widget.label,
                      textAlign: TextAlign.center,
                      style: AppTypography.button(color: foreground),
                    ),
                  ),
                  if (widget.icon != null) ...[
                    const SizedBox(width: 8),
                    Icon(widget.icon, size: 18, color: foreground),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );

    if (!widget.expanded) return button;
    return SizedBox(width: double.infinity, child: button);
  }
}

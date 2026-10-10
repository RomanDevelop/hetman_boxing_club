import 'package:flutter/material.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';
import 'package:hetman_boxing_club/app/theme/app_typography.dart';

Future<void> showVideoDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.82),
    builder: (context) => const Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(20),
      child: _VideoDialog(),
    ),
  );
}

class _VideoDialog extends StatefulWidget {
  const _VideoDialog();

  @override
  State<_VideoDialog> createState() => _VideoDialogState();
}

class _VideoDialogState extends State<_VideoDialog> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _play() {
    setState(() => _playing = true);
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 720),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(child: Text('POZNAJ HETMANA', style: AppTypography.display(32))),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                ],
              ),
              const SizedBox(height: 12),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF4A1016), Color(0xFF12080A)],
                    ),
                  ),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      final done = _controller.isCompleted;
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          if (!_playing)
                            IconButton.filled(
                              style: IconButton.styleFrom(backgroundColor: AppColors.red, foregroundColor: Colors.white),
                              onPressed: _play,
                              iconSize: 42,
                              icon: const Icon(Icons.play_arrow_rounded),
                            )
                          else if (!done)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Odtwarzanie', style: AppTypography.title(22)),
                                  const SizedBox(height: 16),
                                  LinearProgressIndicator(value: _controller.value),
                                ],
                              ),
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Text(
                                'To podgląd atmosfery klubu. Pełny materiał dostaniesz po zapisie na darmowy trening.',
                                textAlign: TextAlign.center,
                                style: AppTypography.body(color: AppColors.textPrimary),
                              ),
                            ),
                        ],
                      );
                    },
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

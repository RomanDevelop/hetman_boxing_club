import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hetman_boxing_club/app/router/app_routes.dart';
import 'package:hetman_boxing_club/app/theme/app_colors.dart';
import 'package:hetman_boxing_club/app/theme/app_typography.dart';
import 'package:hetman_boxing_club/core/widgets/club_card.dart';
import 'package:hetman_boxing_club/core/widgets/club_scroll_view.dart';
import 'package:hetman_boxing_club/core/widgets/hetman_button.dart';
import 'package:hetman_boxing_club/core/widgets/section_header.dart';
import 'package:hetman_boxing_club/features/enrollment/presentation/view_model/enrollment_view_model.dart';
import 'package:hetman_boxing_club/features/groups/presentation/view_model/groups_view_model.dart';

class EnrollmentPage extends ConsumerStatefulWidget {
  const EnrollmentPage({this.initialGroupId, super.key});

  final String? initialGroupId;

  @override
  ConsumerState<EnrollmentPage> createState() => _EnrollmentPageState();
}

class _EnrollmentPageState extends ConsumerState<EnrollmentPage> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _note = TextEditingController();

  @override
  void initState() {
    super.initState();
    final groupId = widget.initialGroupId;
    if (groupId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ref.read(enrollmentViewModelProvider.notifier).selectGroup(groupId);
      });
    }
  }

  @override
  void didUpdateWidget(covariant EnrollmentPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    final groupId = widget.initialGroupId;
    if (groupId != null && groupId != oldWidget.initialGroupId) {
      ref.read(enrollmentViewModelProvider.notifier).selectGroup(groupId);
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    _note.dispose();
    super.dispose();
  }

  void _submit() {
    ref.read(enrollmentViewModelProvider.notifier).submit(
      name: _name.text,
      phone: _phone.text,
      email: _email.text,
      note: _note.text,
    );
  }

  void _reset() {
    _name.clear();
    _phone.clear();
    _email.clear();
    _note.clear();
    ref.read(enrollmentViewModelProvider.notifier).reset();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(enrollmentViewModelProvider);
    final groups = ref.watch(groupsViewModelProvider);
    final selected = groups.where((group) => group.id == state.groupId).firstOrNull;

    return ClubScrollView(
      children: [
        const SectionHeader(title: 'ZAPISZ SIĘ'),
        const SizedBox(height: 8),
        Text(
          'Pierwszy trening jest bezpłatny. Zostaw kontakt, a trener potwierdzi termin.',
          style: AppTypography.body(),
        ),
        const SizedBox(height: 20),
        if (state.submitted)
          _SuccessPanel(name: state.name, onHome: () => context.go(AppRoutes.home), onReset: _reset)
        else
          LayoutBuilder(
            builder: (context, constraints) {
              final form = Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _name,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: 'Imię i nazwisko'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _phone,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: 'Telefon'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: 'E-mail'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _note,
                    minLines: 3,
                    maxLines: 5,
                    decoration: const InputDecoration(labelText: 'Wiadomość (opcjonalnie)'),
                  ),
                  const SizedBox(height: 16),
                  Text('GRUPA', style: AppTypography.label(color: AppColors.textMuted)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final group in groups)
                        ChoiceChip(
                          label: Text('${group.title} · ${group.ageLabel}'),
                          selected: state.groupId == group.id,
                          selectedColor: AppColors.red,
                          backgroundColor: AppColors.surface,
                          side: const BorderSide(color: AppColors.line),
                          labelStyle: AppTypography.body(
                            size: 13,
                            color: state.groupId == group.id ? Colors.white : AppColors.textSecondary,
                          ),
                          onSelected: (_) => ref.read(enrollmentViewModelProvider.notifier).selectGroup(group.id),
                        ),
                    ],
                  ),
                  if (state.error != null) ...[
                    const SizedBox(height: 14),
                    Text(state.error!, style: AppTypography.body(size: 14, color: AppColors.redBright)),
                  ],
                  const SizedBox(height: 18),
                  HetmanButton(
                    label: 'WYŚLIJ ZGŁOSZENIE',
                    icon: Icons.arrow_forward,
                    onPressed: _submit,
                  ),
                ],
              );

              final summary = ClubCard(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('DARMOWY TRENING', style: AppTypography.label(color: AppColors.redBright)),
                    const SizedBox(height: 8),
                    Text(
                      selected == null ? 'Wybierz grupę' : selected.title,
                      style: AppTypography.display(32, style: FontStyle.normal),
                    ),
                    if (selected != null) ...[
                      const SizedBox(height: 6),
                      Text(selected.ageLabel, style: AppTypography.body()),
                      const SizedBox(height: 8),
                      Text(selected.summary, style: AppTypography.body(size: 14, color: AppColors.textPrimary)),
                    ],
                  ],
                ),
              );

              if (constraints.maxWidth < 800) {
                return Column(children: [summary, const SizedBox(height: 16), form]);
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: form),
                  const SizedBox(width: 20),
                  Expanded(flex: 2, child: summary),
                ],
              );
            },
          ),
      ],
    );
  }
}

class _SuccessPanel extends StatelessWidget {
  const _SuccessPanel({required this.name, required this.onHome, required this.onReset});

  final String name;
  final VoidCallback onHome;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return ClubCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: AppColors.red, size: 42)
              .animate()
              .scale(begin: const Offset(0.6, 0.6), duration: 350.ms, curve: Curves.easeOutBack),
          const SizedBox(height: 12),
          Text('Dziękujemy, $name', style: AppTypography.display(36, style: FontStyle.normal)),
          const SizedBox(height: 8),
          Text(
            'Zapis przyjęty. Trener skontaktuje się z Tobą i potwierdzi darmowy trening.',
            style: AppTypography.body(size: 16, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              HetmanButton(label: 'STRONA GŁÓWNA', onPressed: onHome),
              HetmanButton(
                label: 'KOLEJNE ZGŁOSZENIE',
                variant: HetmanButtonVariant.outline,
                onPressed: onReset,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

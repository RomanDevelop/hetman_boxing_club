import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hetman_boxing_club/app/di/providers.dart';

class EnrollmentState {
  const EnrollmentState({
    this.name = '',
    this.groupId,
    this.submitted = false,
    this.error,
  });

  final String name;
  final String? groupId;
  final bool submitted;
  final String? error;

  EnrollmentState copyWith({
    String? name,
    String? groupId,
    bool clearGroup = false,
    bool? submitted,
    String? error,
    bool clearError = false,
  }) {
    return EnrollmentState(
      name: name ?? this.name,
      groupId: clearGroup ? null : groupId ?? this.groupId,
      submitted: submitted ?? this.submitted,
      error: clearError ? null : error ?? this.error,
    );
  }
}

class EnrollmentViewModel extends Notifier<EnrollmentState> {
  @override
  EnrollmentState build() => const EnrollmentState();

  void selectGroup(String id) {
    final groups = ref.read(groupsRepositoryProvider).getGroups();
    final exists = groups.any((group) => group.id == id);
    if (!exists) return;
    state = state.copyWith(groupId: id, clearError: true);
  }

  void submit({
    required String name,
    required String phone,
    required String email,
    required String note,
  }) {
    final trimmedName = name.trim();
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    final trimmedEmail = email.trim();
    final emailOk = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(trimmedEmail);

    if (trimmedName.length < 3) {
      state = state.copyWith(error: 'Podaj imię i nazwisko (min. 3 znaki).');
      return;
    }
    if (digits.length < 9) {
      state = state.copyWith(error: 'Podaj poprawny numer telefonu.');
      return;
    }
    if (!emailOk) {
      state = state.copyWith(error: 'Podaj poprawny adres e-mail.');
      return;
    }
    if (state.groupId == null) {
      state = state.copyWith(error: 'Wybierz grupę treningową.');
      return;
    }
    if (note.trim().length > 400) {
      state = state.copyWith(error: 'Wiadomość może mieć najwyżej 400 znaków.');
      return;
    }

    state = state.copyWith(
      name: trimmedName,
      submitted: true,
      clearError: true,
    );
  }

  void reset() {
    state = const EnrollmentState();
  }
}

final enrollmentViewModelProvider =
    NotifierProvider.autoDispose<EnrollmentViewModel, EnrollmentState>(
      EnrollmentViewModel.new,
    );

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hetman_boxing_club/app/di/providers.dart';
import 'package:hetman_boxing_club/features/club/domain/club_domain.dart';

class ScheduleState {
  const ScheduleState({required this.sessions, this.selectedDay = 1});

  final List<ScheduleSession> sessions;
  final int selectedDay;

  List<ScheduleSession> get visible =>
      sessions.where((session) => session.weekdays.contains(selectedDay)).toList();

  ScheduleState copyWith({int? selectedDay}) {
    return ScheduleState(
      sessions: sessions,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }
}

class ScheduleViewModel extends Notifier<ScheduleState> {
  @override
  ScheduleState build() {
    return ScheduleState(sessions: ref.watch(scheduleRepositoryProvider).getSchedule());
  }

  void selectDay(int day) {
    state = state.copyWith(selectedDay: day);
  }
}

final scheduleViewModelProvider =
    NotifierProvider.autoDispose<ScheduleViewModel, ScheduleState>(ScheduleViewModel.new);

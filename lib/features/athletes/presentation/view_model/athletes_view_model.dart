import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hetman_boxing_club/app/di/providers.dart';
import 'package:hetman_boxing_club/features/club/domain/club_domain.dart';

class AthletesViewModel extends Notifier<List<Athlete>> {
  @override
  List<Athlete> build() => ref.watch(athletesRepositoryProvider).getAthletes();
}

final athletesViewModelProvider = NotifierProvider<AthletesViewModel, List<Athlete>>(
  AthletesViewModel.new,
);

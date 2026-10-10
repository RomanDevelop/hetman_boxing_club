import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hetman_boxing_club/app/di/providers.dart';
import 'package:hetman_boxing_club/features/club/domain/club_domain.dart';

class TrainersViewModel extends Notifier<List<Trainer>> {
  @override
  List<Trainer> build() => ref.watch(trainersRepositoryProvider).getTrainers();
}

final trainersViewModelProvider = NotifierProvider<TrainersViewModel, List<Trainer>>(
  TrainersViewModel.new,
);

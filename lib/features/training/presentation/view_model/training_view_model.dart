import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hetman_boxing_club/app/di/providers.dart';
import 'package:hetman_boxing_club/features/club/domain/club_domain.dart';

class TrainingViewModel extends Notifier<TrainingOffer> {
  @override
  TrainingOffer build() => ref.watch(trainingRepositoryProvider).getOffer();
}

final trainingViewModelProvider = NotifierProvider<TrainingViewModel, TrainingOffer>(
  TrainingViewModel.new,
);

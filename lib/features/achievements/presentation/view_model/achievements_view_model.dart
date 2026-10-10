import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hetman_boxing_club/app/di/providers.dart';
import 'package:hetman_boxing_club/features/club/domain/club_domain.dart';

class AchievementsViewModel extends Notifier<List<Achievement>> {
  @override
  List<Achievement> build() => ref.watch(achievementsRepositoryProvider).getAchievements();
}

final achievementsViewModelProvider =
    NotifierProvider<AchievementsViewModel, List<Achievement>>(AchievementsViewModel.new);

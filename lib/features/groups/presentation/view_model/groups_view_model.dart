import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hetman_boxing_club/app/di/providers.dart';
import 'package:hetman_boxing_club/features/club/domain/club_domain.dart';

class GroupsViewModel extends Notifier<List<TrainingGroup>> {
  @override
  List<TrainingGroup> build() => ref.watch(groupsRepositoryProvider).getGroups();
}

final groupsViewModelProvider =
    NotifierProvider<GroupsViewModel, List<TrainingGroup>>(GroupsViewModel.new);

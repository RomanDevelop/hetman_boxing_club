import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hetman_boxing_club/app/di/providers.dart';
import 'package:hetman_boxing_club/features/club/domain/club_domain.dart';

class HomeViewModel extends Notifier<HomeContent> {
  @override
  HomeContent build() => ref.watch(homeRepositoryProvider).getHome();
}

final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeContent>(
  HomeViewModel.new,
);

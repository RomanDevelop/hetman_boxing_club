import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hetman_boxing_club/app/di/providers.dart';
import 'package:hetman_boxing_club/features/club/domain/club_domain.dart';

class AboutViewModel extends Notifier<AboutContent> {
  @override
  AboutContent build() => ref.watch(aboutRepositoryProvider).getAbout();
}

final aboutViewModelProvider = NotifierProvider<AboutViewModel, AboutContent>(
  AboutViewModel.new,
);

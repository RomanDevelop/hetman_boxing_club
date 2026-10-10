import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hetman_boxing_club/app/di/providers.dart';
import 'package:hetman_boxing_club/features/club/domain/club_domain.dart';

class NewsViewModel extends Notifier<List<NewsPost>> {
  @override
  List<NewsPost> build() => ref.watch(newsRepositoryProvider).getNews();
}

final newsViewModelProvider = NotifierProvider<NewsViewModel, List<NewsPost>>(
  NewsViewModel.new,
);

class NewsDetailViewModel extends Notifier<NewsPost?> {
  NewsDetailViewModel(this.postId);

  final String postId;

  @override
  NewsPost? build() => ref.watch(newsRepositoryProvider).findNews(postId);
}

final newsDetailViewModelProvider =
    NotifierProvider.autoDispose.family<NewsDetailViewModel, NewsPost?, String>(
      NewsDetailViewModel.new,
    );

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hetman_boxing_club/app/di/providers.dart';
import 'package:hetman_boxing_club/features/club/domain/club_domain.dart';

class GalleryState {
  const GalleryState({required this.items, this.category = 'Wszystkie'});

  final List<GalleryItem> items;
  final String category;

  List<String> get categories {
    final names = items.map((item) => item.category).toSet().toList();
    return ['Wszystkie', ...names];
  }

  List<GalleryItem> get visible {
    if (category == 'Wszystkie') return items;
    return items.where((item) => item.category == category).toList();
  }

  GalleryState copyWith({String? category}) {
    return GalleryState(items: items, category: category ?? this.category);
  }
}

class GalleryViewModel extends Notifier<GalleryState> {
  @override
  GalleryState build() {
    return GalleryState(items: ref.watch(galleryRepositoryProvider).getGallery());
  }

  void selectCategory(String category) {
    state = state.copyWith(category: category);
  }
}

final galleryViewModelProvider =
    NotifierProvider.autoDispose<GalleryViewModel, GalleryState>(GalleryViewModel.new);

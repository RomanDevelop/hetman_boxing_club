import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hetman_boxing_club/core/services/external_links.dart';
import 'package:hetman_boxing_club/features/club/data/in_memory_club_repository.dart';
import 'package:hetman_boxing_club/features/club/domain/club_domain.dart';

final externalLinksProvider = Provider<ExternalLinks>(
  (ref) => const UrlLauncherLinks(),
);

final clubRepositoryProvider = Provider<InMemoryClubRepository>(
  (ref) => const InMemoryClubRepository(),
);

final homeRepositoryProvider = Provider<HomeRepository>(
  (ref) => ref.watch(clubRepositoryProvider),
);

final groupsRepositoryProvider = Provider<GroupsRepository>(
  (ref) => ref.watch(clubRepositoryProvider),
);

final trainingRepositoryProvider = Provider<TrainingRepository>(
  (ref) => ref.watch(clubRepositoryProvider),
);

final scheduleRepositoryProvider = Provider<ScheduleRepository>(
  (ref) => ref.watch(clubRepositoryProvider),
);

final trainersRepositoryProvider = Provider<TrainersRepository>(
  (ref) => ref.watch(clubRepositoryProvider),
);

final newsRepositoryProvider = Provider<NewsRepository>(
  (ref) => ref.watch(clubRepositoryProvider),
);

final galleryRepositoryProvider = Provider<GalleryRepository>(
  (ref) => ref.watch(clubRepositoryProvider),
);

final achievementsRepositoryProvider = Provider<AchievementsRepository>(
  (ref) => ref.watch(clubRepositoryProvider),
);

final athletesRepositoryProvider = Provider<AthletesRepository>(
  (ref) => ref.watch(clubRepositoryProvider),
);

final aboutRepositoryProvider = Provider<AboutRepository>(
  (ref) => ref.watch(clubRepositoryProvider),
);

final contactRepositoryProvider = Provider<ContactRepository>(
  (ref) => ref.watch(clubRepositoryProvider),
);

import 'package:hetman_boxing_club/features/club/data/club_catalog.dart';
import 'package:hetman_boxing_club/features/club/domain/club_domain.dart';

final class InMemoryClubRepository
    implements
        HomeRepository,
        GroupsRepository,
        TrainingRepository,
        ScheduleRepository,
        TrainersRepository,
        NewsRepository,
        GalleryRepository,
        AchievementsRepository,
        AthletesRepository,
        AboutRepository,
        ContactRepository {
  const InMemoryClubRepository();

  @override
  HomeContent getHome() => ClubCatalog.home;

  @override
  List<TrainingGroup> getGroups() => ClubCatalog.groups;

  @override
  TrainingOffer getOffer() => ClubCatalog.offer;

  @override
  List<ScheduleSession> getSchedule() => ClubCatalog.schedule;

  @override
  List<Trainer> getTrainers() => ClubCatalog.trainers;

  @override
  List<NewsPost> getNews() => ClubCatalog.news;

  @override
  NewsPost? findNews(String id) {
    for (final post in ClubCatalog.news) {
      if (post.id == id) return post;
    }
    return null;
  }

  @override
  List<GalleryItem> getGallery() => ClubCatalog.gallery;

  @override
  List<Achievement> getAchievements() => ClubCatalog.achievements;

  @override
  List<Athlete> getAthletes() => ClubCatalog.athletes;

  @override
  AboutContent getAbout() => ClubCatalog.about;

  @override
  ContactDetails getContact() => ClubCatalog.contact;
}

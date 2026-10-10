class ClubBrand {
  const ClubBrand({
    required this.overline,
    required this.name,
    required this.city,
    required this.fullName,
  });

  final String overline;
  final String name;
  final String city;
  final String fullName;
}

class HeroContent {
  const HeroContent({
    required this.kicker,
    required this.title,
    required this.accent,
    required this.body,
  });

  final String kicker;
  final String title;
  final String accent;
  final String body;
}

class ClubFeature {
  const ClubFeature({required this.title, required this.iconKey});

  final String title;
  final String iconKey;
}

class HomeContent {
  const HomeContent({
    required this.brand,
    required this.hero,
    required this.features,
    required this.membersCount,
    required this.membersCaption,
  });

  final ClubBrand brand;
  final HeroContent hero;
  final List<ClubFeature> features;
  final int membersCount;
  final String membersCaption;
}

class GroupTag {
  const GroupTag({required this.label, required this.iconKey});

  final String label;
  final String iconKey;
}

class TrainingGroup {
  const TrainingGroup({
    required this.id,
    required this.title,
    required this.ageLabel,
    required this.summary,
    required this.imageUrl,
    required this.tags,
  });

  final String id;
  final String title;
  final String ageLabel;
  final String summary;
  final String imageUrl;
  final List<GroupTag> tags;
}

class TrainingBenefit {
  const TrainingBenefit({required this.title, required this.iconKey});

  final String title;
  final String iconKey;
}

class TrainingOffer {
  const TrainingOffer({
    required this.kicker,
    required this.title,
    required this.body,
    required this.quote,
    required this.discipline,
    required this.benefits,
    required this.imageUrl,
  });

  final String kicker;
  final String title;
  final String body;
  final String quote;
  final String discipline;
  final List<TrainingBenefit> benefits;
  final String imageUrl;
}

class ScheduleSession {
  const ScheduleSession({
    required this.id,
    required this.timeRange,
    required this.groupName,
    required this.groupId,
    required this.enrolled,
    required this.capacity,
    required this.weekdays,
  });

  final String id;
  final String timeRange;
  final String groupName;
  final String groupId;
  final int enrolled;
  final int capacity;
  final List<int> weekdays;

  double get fill => capacity == 0 ? 0 : enrolled / capacity;
}

class Trainer {
  const Trainer({
    required this.id,
    required this.name,
    required this.role,
    required this.summary,
    required this.bio,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String role;
  final String summary;
  final String bio;
  final String imageUrl;
}

class NewsPost {
  const NewsPost({
    required this.id,
    required this.date,
    required this.title,
    required this.excerpt,
    required this.body,
    required this.imageUrl,
  });

  final String id;
  final DateTime date;
  final String title;
  final String excerpt;
  final String body;
  final String imageUrl;
}

class GalleryItem {
  const GalleryItem({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String category;
  final String imageUrl;
}

class Achievement {
  const Achievement({required this.title, required this.iconKey});

  final String title;
  final String iconKey;
}

class Athlete {
  const Athlete({
    required this.id,
    required this.name,
    required this.category,
    required this.highlight,
    required this.medals,
  });

  final String id;
  final String name;
  final String category;
  final String highlight;
  final int medals;
}

class AboutContent {
  const AboutContent({
    required this.title,
    required this.body,
    required this.values,
  });

  final String title;
  final String body;
  final List<String> values;
}

class ContactDetails {
  const ContactDetails({
    required this.city,
    required this.street,
    required this.phoneDisplay,
    required this.phoneUri,
    required this.email,
    required this.mapQuery,
  });

  final String city;
  final String street;
  final String phoneDisplay;
  final String phoneUri;
  final String email;
  final String mapQuery;
}

abstract interface class HomeRepository {
  HomeContent getHome();
}

abstract interface class GroupsRepository {
  List<TrainingGroup> getGroups();
}

abstract interface class TrainingRepository {
  TrainingOffer getOffer();
}

abstract interface class ScheduleRepository {
  List<ScheduleSession> getSchedule();
}

abstract interface class TrainersRepository {
  List<Trainer> getTrainers();
}

abstract interface class NewsRepository {
  List<NewsPost> getNews();

  NewsPost? findNews(String id);
}

abstract interface class GalleryRepository {
  List<GalleryItem> getGallery();
}

abstract interface class AchievementsRepository {
  List<Achievement> getAchievements();
}

abstract interface class AthletesRepository {
  List<Athlete> getAthletes();
}

abstract interface class AboutRepository {
  AboutContent getAbout();
}

abstract interface class ContactRepository {
  ContactDetails getContact();
}

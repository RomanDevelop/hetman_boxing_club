abstract final class AppRoutes {
  static const home = '/';
  static const about = '/o-klubie';
  static const training = '/trening';
  static const groups = '/grupy';
  static const trainers = '/trenerzy';
  static const athletes = '/zawodnicy';
  static const schedule = '/grafik';
  static const news = '/aktualnosci';
  static const gallery = '/galeria';
  static const contact = '/kontakt';
  static const achievements = '/osiagniecia';
  static const enroll = '/zapisz-sie';

  static String newsPost(String id) => '$news/$id';

  static String enrollFor(String groupId) => '$enroll?grupa=$groupId';
}

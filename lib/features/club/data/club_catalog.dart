import 'package:hetman_boxing_club/core/constants/club_photos.dart';
import 'package:hetman_boxing_club/features/club/domain/club_domain.dart';

abstract final class ClubCatalog {
  static const brand = ClubBrand(
    overline: 'A.S.B.K.S.',
    name: 'HETMAN',
    city: 'ZAMOŚĆ',
    fullName: 'A.S.B.K.S. Hetman Zamość',
  );

  static const home = HomeContent(
    brand: brand,
    hero: HeroContent(
      kicker: 'WIĘCEJ NIŻ SPORT',
      title: 'TU RODZI SIĘ',
      accent: 'CHARAKTER',
      body:
          'A.S.B.K.S. Hetman Zamość – boks dla dzieci, młodzieży i dorosłych. Treningi, które rozwijają siłę, dyscyplinę i pewność siebie na całe życie.',
    ),
    membersCount: 120,
    membersCaption: 'ZAWODNIKÓW\nW NASZEJ SPOŁECZNOŚCI',
    features: [
      ClubFeature(title: 'Doświadczeni\ntrenerzy', iconKey: 'coach'),
      ClubFeature(title: 'Treningi dla\nkażdego wieku', iconKey: 'age'),
      ClubFeature(title: 'Bezpieczna\nprzestrzeń', iconKey: 'shield'),
      ClubFeature(title: 'Indywidualne\npodejście', iconKey: 'person'),
      ClubFeature(title: 'Realny\nrozwój', iconKey: 'growth'),
      ClubFeature(title: 'Silna\nspołeczność', iconKey: 'community'),
      ClubFeature(title: 'Medale i\nosiągnięcia', iconKey: 'medal'),
    ],
  );

  static const groups = [
    TrainingGroup(
      id: 'dzieci',
      title: 'DZIECI',
      ageLabel: '5 – 9 LAT',
      summary: 'Pierwsze kroki przez ruch, zabawę i proste zasady sali.',
      imageUrl: ClubPhotos.training,
      tags: [
        GroupTag(label: 'Ruch', iconKey: 'run'),
        GroupTag(label: 'Zabawa', iconKey: 'play'),
        GroupTag(label: 'Dyscyplina', iconKey: 'fire'),
      ],
    ),
    TrainingGroup(
      id: 'mlodziez',
      title: 'MŁODZIEŻ',
      ageLabel: '10 – 16 LAT',
      summary: 'Technika, sparringi kontrolowane i starty w zawodach.',
      imageUrl: ClubPhotos.match,
      tags: [
        GroupTag(label: 'Technika', iconKey: 'technique'),
        GroupTag(label: 'Charakter', iconKey: 'character'),
        GroupTag(label: 'Rozwój', iconKey: 'growth'),
      ],
    ),
    TrainingGroup(
      id: 'dorosli',
      title: 'DOROŚLI',
      ageLabel: '16+',
      summary: 'Kondycja, samoobrona i sport dla osób po 16. roku życia.',
      imageUrl: ClubPhotos.boxer,
      tags: [
        GroupTag(label: 'Kondycja', iconKey: 'fitness'),
        GroupTag(label: 'Samoobrona', iconKey: 'defense'),
        GroupTag(label: 'Sport', iconKey: 'sport'),
      ],
    ),
    TrainingGroup(
      id: 'grupa30',
      title: 'GRUPA 30+',
      ageLabel: 'DLA DOROSŁYCH',
      summary: 'Forma, zdrowie i pewność siebie we własnym tempie.',
      imageUrl: ClubPhotos.gym,
      tags: [
        GroupTag(label: 'Forma', iconKey: 'form'),
        GroupTag(label: 'Zdrowie', iconKey: 'health'),
        GroupTag(label: 'Pewność siebie', iconKey: 'confidence'),
      ],
    ),
  ];

  static const offer = TrainingOffer(
    kicker: 'PIERWSZY RAZ',
    title: 'DARMOWY\nTRENING',
    body:
        'Przyjdź i zobacz, jak wygląda nasza atmosfera. Twój pierwszy trening jest bezpłatny!',
    quote:
        'Nie da się pokonać człowieka, który mimo porażek wciąż wstaje i idzie dalej…',
    discipline: 'DISCIPLINE\nBUILDS\nFREEDOM',
    imageUrl: ClubPhotos.boxer,
    benefits: [
      TrainingBenefit(title: 'Profesjonalni trenerzy', iconKey: 'coach'),
      TrainingBenefit(title: 'Nowoczesna sala i sprzęt', iconKey: 'shield'),
      TrainingBenefit(title: 'Przyjazna atmosfera', iconKey: 'community'),
      TrainingBenefit(title: 'Udział w zawodach i obozach', iconKey: 'camp'),
      TrainingBenefit(title: 'Wsparcie na każdym etapie', iconKey: 'growth'),
    ],
  );

  static const weekdays = [0, 1, 2, 3, 4, 5];

  static const schedule = [
    ScheduleSession(
      id: 's-dzieci',
      timeRange: '17:00 – 18:00',
      groupName: 'Dzieci (5–9 lat)',
      groupId: 'dzieci',
      enrolled: 12,
      capacity: 16,
      weekdays: weekdays,
    ),
    ScheduleSession(
      id: 's-mlodziez',
      timeRange: '18:00 – 19:30',
      groupName: 'Młodzież (10–16 lat)',
      groupId: 'mlodziez',
      enrolled: 8,
      capacity: 14,
      weekdays: weekdays,
    ),
    ScheduleSession(
      id: 's-dorosli',
      timeRange: '19:30 – 21:00',
      groupName: 'Dorośli 16+',
      groupId: 'dorosli',
      enrolled: 10,
      capacity: 14,
      weekdays: weekdays,
    ),
    ScheduleSession(
      id: 's-grupa30',
      timeRange: '19:30 – 21:00',
      groupName: 'Grupa 30+ (dorośli)',
      groupId: 'grupa30',
      enrolled: 6,
      capacity: 12,
      weekdays: weekdays,
    ),
  ];

  static const trainers = [
    Trainer(
      id: 'dmitriy',
      name: 'Dmitriy S.',
      role: 'Trener główny',
      summary: 'Wieloletnie doświadczenie w szkoleniu dzieci i młodzieży.',
      bio:
          'Prowadzi grupy młodzieżowe i odpowiada za plan startów. Stawia na technikę, spokój w ringu i rozwój charakteru, nie tylko na wynik.',
      imageUrl: ClubPhotos.portrait,
    ),
    Trainer(
      id: 'anna',
      name: 'Anna K.',
      role: 'Trenerka',
      summary: 'Treningi techniczne, kondycyjne, sparringi.',
      bio:
          'Uczy pracy nóg, gardy i kontrolowanego sparringu. Prowadzi zajęcia dla dzieci oraz dorosłych, którzy wracają do formy.',
      imageUrl: ClubPhotos.training,
    ),
    Trainer(
      id: 'sergey',
      name: 'Sergey L.',
      role: 'Trener',
      summary: 'Indywidualne podejście i rozwój zawodniczy.',
      bio:
          'Przygotowuje zawodników do turniejów regionalnych i układa plany pod konkretną osobę: od pierwszego treningu po walkę.',
      imageUrl: ClubPhotos.boxer,
    ),
  ];

  static final news = [
    NewsPost(
      id: 'nikita',
      date: DateTime(2025, 3, 12),
      title: 'Sukces Nikity! Zawodnik miesiąca',
      excerpt: 'Nikita K. wygrywa turniej młodzieżowy i zostaje zawodnikiem miesiąca.',
      body:
          'Na marcowym turnieju w regionie Nikita K. wygrał wszystkie trzy walki i zamknął zawody złotem w swojej kategorii.\n\nTrenerzy wyróżnili go nie tylko za wynik, ale za spokój między rundami i pracę na treningach przez całą zimę. W klubie zostaje zawodnikiem miesiąca.',
      imageUrl: ClubPhotos.match,
    ),
    NewsPost(
      id: 'nowa-grupa',
      date: DateTime(2025, 3, 12),
      title: 'Treningi bez granic. Nowa grupa startuje',
      excerpt: 'Grupa 30+ rusza w nowym sezonie. Pierwszy trening jest bezpłatny.',
      body:
          'Od marca na sali działa osobna grupa dla dorosłych 30+. Tempo dobieramy do osób, które chcą wrócić do ruchu, zadbać o kondycję albo po prostu spróbować boksu.\n\nZapisy są otwarte. Pierwsze zajęcia nic nie kosztują — przychodzisz, patrzysz i decydujesz.',
      imageUrl: ClubPhotos.gym,
    ),
    NewsPost(
      id: 'oboz',
      date: DateTime(2025, 3, 2),
      title: 'Obóz zimowy za nami',
      excerpt: 'Trzy dni techniki, sparringów i wspólnego stołu. Wracamy mocniejsi.',
      body:
          'Zimowy obóz Hetmana zebrał młodzież i starszych zawodników. Rano technika, po południu kondycja, wieczorem omówienie walk.\n\nTo był czas, w którym widać klub najlepiej: starsi pomagają młodszym, a każdy wraca z konkretnym zadaniem na kolejne tygodnie.',
      imageUrl: ClubPhotos.crowd,
    ),
    NewsPost(
      id: 'zapisy',
      date: DateTime(2025, 2, 18),
      title: 'Zapisy na darmowy trening',
      excerpt: 'Dzieci, młodzież i dorośli mogą przyjść na pierwsze zajęcia bez opłaty.',
      body:
          'Jeśli wahasz się, czy boks jest dla Ciebie albo dla dziecka, przyjdź na jeden trening. Pokażemy salę, zasady i sposób pracy trenerów.\n\nWeź wygodny strój i wodę. Rękawice na pierwszy raz są na miejscu.',
      imageUrl: ClubPhotos.ring,
    ),
  ];

  static const gallery = [
    GalleryItem(
      id: 'g1',
      title: 'Praca na łapach',
      category: 'Treningi',
      imageUrl: ClubPhotos.boxer,
    ),
    GalleryItem(
      id: 'g2',
      title: 'Sala Hetmana',
      category: 'Treningi',
      imageUrl: ClubPhotos.gym,
    ),
    GalleryItem(
      id: 'g3',
      title: 'Turniej regionalny',
      category: 'Zawody',
      imageUrl: ClubPhotos.match,
    ),
    GalleryItem(
      id: 'g4',
      title: 'Po walce',
      category: 'Zawody',
      imageUrl: ClubPhotos.portrait,
    ),
    GalleryItem(
      id: 'g5',
      title: 'Obóz zimowy',
      category: 'Obóz',
      imageUrl: ClubPhotos.crowd,
    ),
    GalleryItem(
      id: 'g6',
      title: 'Wspólna drużyna',
      category: 'Społeczność',
      imageUrl: ClubPhotos.training,
    ),
  ];

  static const achievements = [
    Achievement(title: 'Medale i puchary na zawodach', iconKey: 'cup'),
    Achievement(title: 'Rozwój zawodników na każdym etapie', iconKey: 'growth'),
    Achievement(title: 'Udział w turniejach regionalnych', iconKey: 'medal'),
    Achievement(title: 'Silna społeczność i drużyna', iconKey: 'community'),
  ];

  static const athletes = [
    Athlete(
      id: 'nikita',
      name: 'Nikita K.',
      category: 'Młodzież',
      highlight: 'Zawodnik miesiąca',
      medals: 3,
    ),
    Athlete(
      id: 'maja',
      name: 'Maja W.',
      category: 'Młodzież',
      highlight: 'Wicemistrzyni regionu',
      medals: 2,
    ),
    Athlete(
      id: 'adam',
      name: 'Adam R.',
      category: 'Dorośli',
      highlight: 'Debiut na ringu',
      medals: 1,
    ),
    Athlete(
      id: 'oliwia',
      name: 'Oliwia P.',
      category: 'Dzieci',
      highlight: 'Najlepsza technika miesiąca',
      medals: 1,
    ),
  ];

  static const about = AboutContent(
    title: 'O KLUBIE',
    body:
        'Tworzymy miejsce, w którym każdy – niezależnie od wieku – może rozwijać siłę, budować charakter i stawać się lepszą wersją siebie.',
    values: ['PASJA', 'DYSCYPLINA', 'SUKCES', 'SZACUNEK'],
  );

  static const contact = ContactDetails(
    city: 'Zamość',
    street: 'ul. Partyzantów 14',
    phoneDisplay: '+48 500 123 456',
    phoneUri: '+48500123456',
    email: 'hetman@zamosc.pl',
    mapQuery: 'Zamość, ul. Partyzantów 14',
  );
}

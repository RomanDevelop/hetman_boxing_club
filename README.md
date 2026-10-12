# A.S.B.K.S. Hetman Zamość

Public site and phone app for the boxing club in Zamość. One Flutter project runs in the browser and on iOS and Android. Visitor-facing copy is in Polish.

Live site: https://hetman-boxing-club.web.app

Firebase project: [hetman-boxing-club](https://console.firebase.google.com/project/hetman-boxing-club/overview)

## What visitors see

The home page is one long landing page on every screen width:

1. Team banner
2. Hero with three photos that crossfade every 3 seconds
3. Feature strip
4. Four training groups
5. Free-training offer
6. Weekly schedule
7. Trainers
8. Gallery preview
9. Achievements
10. Footer

Other sections are also their own routes. Page changes fade and slide slightly.

**Wide screens (1080px and up).** The top bar stays visible. From 1280px it shows the full link row: O klubie, Trening, Trenerzy, Zawodnicy, Grafik, Aktualności, Galeria, Kontakt, plus a WhatsApp button and the side menu. Between 1080px and 1280px the link row is hidden and the menu button remains. Content is centered at a maximum width of 1180px. The footer is shown on every page.

**Phones (under 1080px).** The home page still scrolls through every landing module. A bottom bar jumps to Trening (home), Trenerzy, Grafik, and Kontakt. Everything else, including enrollment, is in the side menu. The footer is on the home page.

The brand mark inside the app, in the browser tab, and on the phone icon is the gold HETMAN ZAMOŚĆ emblem (`assets/images/logo_hetman.png`). The launch screen uses the gold A.S.B. HETMAN ZAMOŚĆ emblem (`assets/images/logo_splash.png`). Navigation icons are ordinary interface icons, not the emblem.

## Sign-up

There is no backend. After the form is valid, the app opens WhatsApp with a prepared Polish message. The visitor still has to press Send.

The message includes name, phone, email, the chosen group, and an optional note (400 characters max). Validation requires a name of at least 3 characters, a phone number with at least 9 digits, an email address, and a group.

Buttons that start this flow say that the message goes through WhatsApp. A schedule row can preselect its group with `/zapisz-sie?grupa=<id>`. The Friday combined session uses the id `wspolny`, which is not a real group, so the form does not preselect anything for that row.

The WhatsApp number and the Facebook page are in `ClubCatalog.contact`:

| Channel | Value |
| --- | --- |
| WhatsApp sign-up | `+48 500 557 114` (`wa.me/48500557114`) |
| Facebook icon | https://www.facebook.com/profile.php?id=100064851904742 |
| Call and email shown in the footer | still the values in `phoneDisplay` and `email` in the same catalog |

Instagram and YouTube icons in the footer are not linked yet. They show a short “coming soon” notice.

The hero “Zobacz wideo” button plays the club Facebook reel. On web it opens an overlay player. On a phone it opens the reel URL.

## Schedule

Monday to Friday only. Occupancy numbers on the cards are static display data, not a live count.

| Days | Time | Group |
| --- | --- | --- |
| Monday, Wednesday | 17:00–18:00 | Boxing Kids |
| Monday, Wednesday | 18:00–19:30 | Grupa początkująca |
| Tuesday, Thursday | 18:00–19:30 | Grupa zaawansowana |
| Tuesday, Thursday | 19:30–21:00 | Dorośli 30+ |
| Friday | 17:00–18:30 | Grupa początkująca + zaawansowana |

Weekday indexes in the catalog are `0` Monday through `4` Friday.

## Architecture

Feature-first MVVM.

- A **view** is a page or section widget. It watches a Riverpod provider and draws the screen.
- A **view model** is a `Notifier`. Most of them only read the repository. `EnrollmentViewModel` holds the form state and opens WhatsApp.
- **Domain** models and repository interfaces live in `lib/features/club/domain/club_domain.dart`.
- **Data** is the in-memory `ClubCatalog`, exposed by one `InMemoryClubRepository`. Providers in `lib/app/di/providers.dart` hand that same object out through each repository interface, so a screen depends on `GroupsRepository` rather than on the catalog type.
- **Routing** is `go_router` with path URLs (`usePathUrlStrategy`) and one `ShellRoute` for the app bar, drawer, and bottom navigation.
- **Links** (WhatsApp, phone, email, maps, Facebook) go through `ExternalLinks`, so tests can replace the launcher.

```
lib/
  main.dart                 app entry, path URLs, ProviderScope
  app/                      theme, router, Riverpod providers
  core/                     shared widgets, breakpoints, icons, link opening
  features/
    club/                   domain models, catalog, in-memory repository
    shell/                  bars, drawer, bottom navigation
    home/                   landing page, hero, Facebook reel
    about/ groups/ training/ schedule/ trainers/
    athletes/ news/ gallery/ achievements/ contact/
    enrollment/             free-training form
```

Screens that only display catalog data keep the view model thin on purpose. New club copy belongs in the catalog, not in the widget.

## Editing the club

| Change | Where |
| --- | --- |
| Hero text, feature strip | `ClubCatalog.home` |
| Group names and descriptions | `ClubCatalog.groups` |
| Free-training offer | `ClubCatalog.offer` |
| Weekly plan | `ClubCatalog.schedule` |
| Trainer names and bios | `ClubCatalog.trainers` |
| About page | `ClubCatalog.about` |
| Phone, email, address, WhatsApp, Facebook | `ClubCatalog.contact` |
| News, gallery, athletes, achievements | the matching lists in `club_catalog.dart` |
| Photos | `assets/images/`, then point the catalog or widget at the new filename |

`assets/images/` is declared as a folder in `pubspec.yaml`, so a new file in that folder is bundled on the next build. Hosting caches `/assets/**` for one year as immutable, so a replaced photo needs a **new filename**. Reusing the old name will keep the old image for returning visitors.

Hero frames are listed in `HeroSlideshow.photos`. Trainer cards use a 2:3 frame so the poster text stays visible.

## Routes

| Path | Screen |
| --- | --- |
| `/` | Home |
| `/o-klubie` | About |
| `/trening` | Training |
| `/grupy` | Groups |
| `/trenerzy` | Trainers |
| `/zawodnicy` | Athletes |
| `/grafik` | Schedule |
| `/aktualnosci` | News |
| `/aktualnosci/:id` | One news post |
| `/galeria` | Gallery |
| `/osiagniecia` | Achievements |
| `/kontakt` | Contact |
| `/zapisz-sie` | Free-training form |
| `/zapisz-sie?grupa=<id>` | Form with that group selected |

Unknown paths show the not-found state inside the same shell. Firebase rewrites every path to `index.html`, so a refresh on `/grafik` still opens the app. A plain static server does not do that rewrite.

## Run and test

Requirements: Flutter SDK compatible with Dart `^3.7.2`.

```bash
flutter pub get
flutter run -d chrome
```

Local web server:

```bash
flutter run -d web-server --web-port=8080 --web-hostname=127.0.0.1
```

Phone or emulator:

```bash
flutter run
```

```bash
flutter analyze
flutter test
```

`flutter test` covers the home headline and the enrollment rules, including the WhatsApp link. Widget tests disable Google Fonts network fetching.

## Build and publish

Hosting is configured in `firebase.json` (`public` is `build/web`) and `.firebaserc` (project `hetman-boxing-club`). Use Node 20 or newer. If a global `firebase` binary is broken, call the CLI through `npx`.

`web/index.html` loads `flutter_bootstrap.js` with a `?v=` query so browsers do not keep an old app shell. After `flutter build web`, patch the generated bootstrap the same way, or the new `main.dart.js` will not load:

```bash
flutter build web --release

python3 -c '
from pathlib import Path
p = Path("build/web/flutter_bootstrap.js")
text = p.read_text()
old = "c(\"main.dart.js\")"
new = "c(\"main.dart.js?v=YYYYMMDD\")"  # same token as web/index.html
if text.count(old) != 1:
    raise SystemExit("unexpected bootstrap")
p.write_text(text.replace(old, new, 1))
'

npx firebase-tools@latest deploy --only hosting --project hetman-boxing-club
```

Bump the `?v=` token whenever the app script changes. HTML and the app script are served with `Cache-Control: no-cache`. CanvasKit and files under `/assets/` are cached as immutable.

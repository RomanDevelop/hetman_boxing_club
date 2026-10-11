# A.S.B.K.S. Hetman Zamość

Сайт и приложение боксёрского клуба из Замосця. Один Flutter-проект открывается в браузере и на телефоне.

Сайт: https://hetman-boxing-club.web.app

Консоль Firebase: https://console.firebase.google.com/project/hetman-boxing-club/overview

## Что внутри

На широком экране главная — длинная страница: баннер команды, герой со сменой фото, группы, тренинг, график, тренеры, галерея, достижения и подвал.

На телефоне та же главная прокручивается целиком. Снизу навигация: тренинг, тренеры, график, контакт. Остальные разделы — в боковом меню.

Контент на польском. Запись на тренировку проверяет имя, телефон, почту и группу.

## Стек

- Flutter, Dart `^3.7.2`
- Riverpod, экраны по схеме MVVM
- go_router
- google_fonts, flutter_animate, url_launcher
- Firebase Hosting, проект `hetman-boxing-club`

Код разложен по фичам в `lib/features`. Общие виджеты и тема — в `lib/core` и `lib/app`. Данные клуба лежат в `lib/features/club/data/club_catalog.dart`.

## Запуск

```bash
flutter pub get
flutter run -d chrome
```

Локальный веб-сервер:

```bash
flutter run -d web-server --web-port=8080 --web-hostname=127.0.0.1
```

Телефон:

```bash
flutter run
```

Проверки:

```bash
flutter analyze
flutter test
```

## Сборка и публикация

Нужен Node 20 или новее. Глобальный `firebase` в системе может быть сломан, поэтому используется `npx`.

```bash
flutter build web --release
npx firebase-tools@latest deploy --only hosting --project hetman-boxing-club
```

Сборка берётся из `build/web`. Настройки хостинга — в `firebase.json`: маршруты вроде `/trenerzy` открывают приложение, а не 404.

## Маршруты

| Путь | Раздел |
| --- | --- |
| `/` | Главная |
| `/o-klubie` | О клубе |
| `/trening` | Тренинг |
| `/grupy` | Группы |
| `/trenerzy` | Тренеры |
| `/zawodnicy` | Спортсмены |
| `/grafik` | Расписание |
| `/aktualnosci` | Новости |
| `/galeria` | Галерея |
| `/osiagniecia` | Достижения |
| `/kontakt` | Контакт |
| `/zapisz-sie` | Запись |

Фото клуба лежат в `assets/images/`.

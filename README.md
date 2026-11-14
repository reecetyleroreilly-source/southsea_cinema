# Southsea Cinema

A Flutter Android app for browsing films, selecting tickets, managing a basket and saving bookings.

## Features

### Browse films

- Loads film information from the app's local JSON data.
- Displays film posters, descriptions, age ratings, screening dates and prices.
- Provides a movie details screen with ticket quantity selection.

### Basket and checkout

- Allows users to select between one and five tickets.
- Adds selected tickets to the basket.
- Shows the selected film, screening date, quantity and line total.
- Calculates the basket subtotal and total.
- Allows basket items to be removed before checkout.
- Saves completed bookings locally and shows a confirmation message.

### Booking history

- Stores bookings in a local SQLite database.
- Assigns each booking a booking number, summary, total and date.
- Displays saved bookings in booking-number order.

### User settings

- Stores the user's name, address and email address.
- Allows users to enable or disable email newsletters.
- Provides a font-size control from 0.8x to 1.5x for readability.
- Supports light and dark themes.
- Saves settings using `shared_preferences` so they are restored when the app is opened again.

## Project structure

```text
southsea_cinema/
├── assets/
│   ├── data/
│   │   └── moviejson.json
│   └── images/
│       ├── Iron Man Poster.jpg
│       ├── MegaMind Poster.jpg
│       └── Pacific Rim Poster.jpg
├── lib/
│   ├── database/
│   │   └── cinema_db.dart
│   ├── models/
│   │   ├── booking_record.dart
│   │   ├── cart_item.dart
│   │   ├── font_size_settings.dart
│   │   ├── movie.dart
│   │   └── user_settings.dart
│   ├── repositories/
│   │   ├── cart_repository.dart
│   │   └── movie_respository.dart
│   ├── views/
│   │   ├── basket_view.dart
│   │   ├── booking_view.dart
│   │   ├── home_view.dart
│   │   ├── movie_listing_view.dart
│   │   └── settings_view.dart
│   ├── widgets/
│   │   ├── basket_button.dart
│   │   ├── booking_button.dart
│   │   ├── movie_card.dart
│   │   ├── nav_drawer.dart
│   │   ├── primary_button.dart
│   │   └── settings_button.dart
│   ├── constants.dart
│   └── main.dart
├── test/
│   ├── database/
│   ├── models/
│   ├── repository/
│   ├── view/
│   └── widget/
├── pubspec.yaml
└── README.md
```

## Screenshots

### Home screen

_Add a home screen screenshot here._

### Basket screen

_Add a basket screen screenshot here._

## Android support

This app supports **Android only** and is designed to run on an Android emulator or device.

## Installation

Clone the repository and install the dependencies:

```bash
git clone <repository-url>
cd southsea_cinema
flutter pub get
```

## Running the app

Start an Android emulator, then check the available devices:

```bash
flutter emulators
flutter emulators --launch <emulator-id>
flutter devices
```

Run the app:

```bash
flutter run -d <android-device-id>
```

## Running tests

```bash
flutter test
```

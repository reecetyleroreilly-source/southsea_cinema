import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/cart_item.dart';
import 'package:southsea_cinema/repositories/cart_repository.dart';
import 'package:southsea_cinema/views/basket_view.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/views/settings_view.dart';
//import 'package:flutter/services.dart';
import 'package:southsea_cinema/database/cinema_db.dart';
import 'package:southsea_cinema/models/booking_record.dart';
import 'package:southsea_cinema/views/booking_view.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'movie_listing_test.dart';

void main() {
  setUp(() async {
    sqfliteFfiInit();
    final Database database = await databaseFactoryFfiNoIsolate.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: MovieDataBase.instance.createTables,
      ),
    );
    MovieDataBase.instance.setDatabase(database);

      SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();
  });

  tearDown(() async {
    await MovieDataBase.instance.close();
  });

  testWidgets(
      'MovieScreen shows the movie list and a basket button, settings button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomeView()));

    expect(find.byType(HomeView), findsWidgets);
    expect(find.byIcon(Icons.person_outline), findsOneWidget);
    expect(find.byIcon(Icons.shopping_basket), findsOneWidget);
  });

  testWidgets('Taping basket button navigates to Basket Screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) {
            return const HomeView();
          },
          '/basket': (BuildContext context) {
            return const BasketScreen();
          }
        },
      ),
    );
    await tester.tap(find.byIcon(Icons.shopping_basket));
    await tester.pumpAndSettle();

    expect(find.byType(BasketScreen), findsOneWidget);
  });

  testWidgets('Taping settings button navigates to settings Screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) {
            return const HomeView();
          },
          '/settings': (BuildContext context) {
            return const SettingsScreen();
          }
        },
      ),
    );
    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();

    expect(find.byType(SettingsScreen), findsOneWidget);
  });

  testWidgets('Checkout saves the order, clears the basket and opens booking', (
    WidgetTester tester,
  ) async {
     CartRepository.instance.additem(
      const Cartitem(movie: testMovie, quantity: 2, date: 'Test'),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: const BasketScreen(),
        routes: {
          '/bookings': (BuildContext context) {
            return const BookingView();
          },
        },
      ),
    );

      await tester.runAsync(() async {
      await tester.tap(find.text('checkout'));
      await tester.pumpAndSettle();
    });
    await tester.pumpAndSettle();

       final List<BookingRecord>? bookings = await tester.runAsync(() async {
      return await MovieDataBase.instance.getAllbookings();
    });

     expect(bookings, isNotNull);
    if (bookings != null) {
      expect(bookings.length, 1);
      expect(bookings[0].bookingNumber, 1001);
      expect(bookings[0].summary, '2 X Iron Man 3');
      expect(bookings[0].total, 15.00);
    }
    expect(CartRepository.instance.getItems(), isEmpty);
    expect(find.byType(BookingView), findsOneWidget);
    expect(find.text('Order #1001'), findsOneWidget);
  });

  testWidgets('Checkout keeps the basket when saving fails', (
    WidgetTester tester,
  ) async {
    CartRepository.instance.additem(
      const Cartitem(movie: testMovie, quantity: 2, date: 'test'),
    );

     await tester.runAsync(() async {
      final Database database = await MovieDataBase.instance.database;
      await database.execute('DROP TABLE booking');
    });

    await tester.pumpWidget(const MaterialApp(home: BasketScreen()));
    await tester.runAsync(() async {
      await tester.tap(find.text('checkout'));
      await tester.pumpAndSettle();
    });
    await tester.pumpAndSettle();

    expect(CartRepository.instance.getItems().length, 1);
    expect(find.text('2 x Iron Man 3'), findsOneWidget);
    expect(find.textContaining('Could not save your booking: []'), findsOneWidget);
  });
}

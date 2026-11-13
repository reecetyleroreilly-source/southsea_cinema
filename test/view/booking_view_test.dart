import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/database/cinema_db.dart';
import 'package:southsea_cinema/models/booking_record.dart';
import 'package:southsea_cinema/views/booking_view.dart';
import 'package:sqflite_common_ffi/sqflite_common_ffi.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';


void main(){

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
   testWidgets('BookingView lists saved orders newest-first', (
    WidgetTester tester,
  ) async {
    await tester.runAsync(() async {
      await MovieDataBase.instance.insertBooking(
        const BookingRecord(
          bookingNumber: 1001,
          summary: '1 x Pacific Rim',
          total: 4.50,
          date: '01/01/2026 10:00',
        ),
      );

      await MovieDataBase.instance.insertBooking(
        const BookingRecord(
          bookingNumber: 1002,
          summary: '2 x Iron Man 3',
          total: 15.00,
          date: '02/01/2026 11:00',
        ),
      );

      await tester.pumpWidget(const MaterialApp(home: BookingView()));
      await tester.pumpAndSettle();
    });

        await tester.pump();

    expect(find.text('Order #1002'), findsOneWidget);
    expect(find.text('Order #1001'), findsOneWidget);
    expect(find.text('2 x Iron Man 3'), findsOneWidget);
    final double newestY = tester.getTopLeft(find.text('Order #1002')).dy;
    final double oldestY = tester.getTopLeft(find.text('Order #1001')).dy;
    expect(newestY, lessThan(oldestY));
  });

  testWidgets('BookingView shows an empty state when there are no orders', (
    WidgetTester tester,
  ) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(const MaterialApp(home: BookingView()));
      await tester.pumpAndSettle();
    });
    await tester.pump();

    expect(find.text('No bookings yet'), findsOneWidget);
  });
}
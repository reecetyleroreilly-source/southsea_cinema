import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/database/cinema_db.dart';
import 'package:southsea_cinema/models/booking_item.dart';
import 'package:southsea_cinema/models/booking_record.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUp(() async {
    sqfliteFfiInit();
    final Database database = await databaseFactoryFfiNoIsolate.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: 2,
        onConfigure: MovieDataBase.instance.configureDatabase,
        onCreate: MovieDataBase.instance.createTables,
      ),
    );
    MovieDataBase.instance.setDatabase(database);
  });

  tearDown(() async {
    await MovieDataBase.instance.close();
  });

  BookingRecord buildRecord(int bookingNumber, String summary, double total) {
    return BookingRecord(
      bookingNumber: bookingNumber,
      summary: summary,
      total: total,
      date: '01/01/2026 10:00',
    );
  }

  test('insertBooking stores an Book and returns its id', () async {
    final int id = await MovieDataBase.instance.insertBooking(
      buildRecord(1001, '1 x Iron Man 3', 7.50),
    );
    expect(id, greaterThan(0));

    final List<BookingRecord> bookings =
        await MovieDataBase.instance.getAllbookings();
    expect(bookings.length, 1);
    expect(bookings[0].id, id);
    expect(bookings[0].summary, '1 x Iron Man 3');
    expect(bookings[0].total, 7.50);
  });

  test('getNextBookingrNumber increments the current maximum', () async {
    expect(await MovieDataBase.instance.getNextBookingNumber(), 1001);

    await MovieDataBase.instance.insertBooking(
      buildRecord(1005, 'Book', 5.0),
    );
    expect(await MovieDataBase.instance.getNextBookingNumber(), 1006);
  });

  test('getAllbookings returns newest booking number first', () async {
    await MovieDataBase.instance.insertBooking(
      buildRecord(1001, 'First', 5.0),
    );
    await MovieDataBase.instance.insertBooking(
      buildRecord(1003, 'Third', 9.0),
    );
    await MovieDataBase.instance.insertBooking(
      buildRecord(1002, 'Second', 7.0),
    );

    final List<BookingRecord> bookings =
        await MovieDataBase.instance.getAllbookings();
    expect(bookings[0].bookingNumber, 1003);
    expect(bookings[1].bookingNumber, 1002);
    expect(bookings[2].bookingNumber, 1001);
  });

  test('database stores a booking and linked items', () async {
    final BookingRecord booking = buildRecord(
      1007,
      '2 x Iron Man 3',
      15.00,
    );
    final int bookingId = await MovieDataBase.instance.insertBookingWithItems(
      booking,
      const <BookingItem>[
        BookingItem(
          movieId: 'iron-man-3',
          movieName: 'Iron Man 3',
          price: 7.50,
          quantity: 2,
        ),
      ],
    );

    final List<BookingItem> items =
        await MovieDataBase.instance.getBookingItems(bookingId);
    expect(items.length, 1);
    expect(items[0].bookingId, bookingId);
    expect(items[0].movieId, 'iron-man-3');
    expect(items[0].movieName, 'Iron Man 3');
    expect(items[0].price, 7.50);
    expect(items[0].quantity, 2);

    final List<BookingRecord> bookings =
        await MovieDataBase.instance.getAllbookings();
    expect(bookings[0].items.length, 1);
  });

  test('foreign keys block an item linked to a missing booking', () async {
    final Database database = await MovieDataBase.instance.database;
    await database.execute(
      'PRAGMA foreign_keys = ON',
    );

    expect(
      () => database.execute(
        'INSERT INTO BookingItem '
        '(booking_id, movie_id, movie_name, price, quantity) '
        'VALUES (9999, "movie-1", "Test Movie", 5.0, 1)',
      ),
      throwsA(isA<DatabaseException>()),
    );
  });

  test('rollback removes the booking when an item is invalid', () async {
    final BookingRecord booking = buildRecord(
      1008,
      '1 x Test Movie',
      5.00,
    );

    await expectLater(
      () => MovieDataBase.instance.insertBookingWithItems(
        booking,
        const <BookingItem>[
          BookingItem(
            movieId: 'movie-1',
            movieName: 'Test Movie',
            price: 5.00,
            quantity: 0,
          ),
        ],
      ),
      throwsA(isA<DatabaseException>()),
    );

    final List<BookingRecord> bookings =
        await MovieDataBase.instance.getAllbookings();
    expect(bookings, isEmpty);
  });

  test('creating the item table preserves existing bookings', () async {
    final Database database = await MovieDataBase.instance.database;
    await database.insert('Booking', <String, Object?>{
      'booking_number': 1009,
      'summary': 'Legacy 1 x Pacific Rim',
      'total': 6.50,
      'date': '02/03/2026 18:10',
    });

    await MovieDataBase.instance.createTables(database, 2);

    final List<BookingRecord> bookings =
        await MovieDataBase.instance.getAllbookings();
    expect(bookings.length, 1);
    expect(bookings[0].summary, 'Legacy 1 x Pacific Rim');
    expect(bookings[0].total, 6.50);
    expect(bookings[0].items, isEmpty);
  });

  test('database creation makes both booking tables', () async {
    final Database database = await MovieDataBase.instance.database;
    final List<Map<String, Object?>> tables = await database.rawQuery(
      "SELECT name FROM sqlite_master "
      "WHERE type = 'table' AND name IN ('Booking', 'BookingItem') "
      "ORDER BY name",
    );

    expect(tables.length, 2);
  });

  test('foreign key pragma is enabled', () async {
    final Database database = await MovieDataBase.instance.database;
    final List<Map<String, Object?>> rows =
        await database.rawQuery('PRAGMA foreign_keys');

    expect(rows[0]['foreign_keys'], 1);
  });
}

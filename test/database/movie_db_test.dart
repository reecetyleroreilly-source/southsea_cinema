import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/database/cinema_db.dart';
import 'package:southsea_cinema/models/booking_record.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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
}
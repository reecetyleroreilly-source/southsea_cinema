import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/booking_record.dart';

void main() {
   const BookingRecord booking = BookingRecord(
    bookingNumber: 1004,
    summary: '2 x Iron Man3',
    total: 16.50,
    date: '01/01/2026 09:05',
  );

  test('New bookings omit database ids and convert to map', () {
    expect(booking.id, isNull);
    expect(booking.toMap(), <String, Object?>{
      'booking_number': 1004,
      'summary': '2 x Iron Man3',
      'total': 16.50,
      'date': '01/01/2026 09:05',
    });
  });

 test('A database map converts back into an booking', () {
    final Map<String, Object?> row = <String, Object?>{
      'id': 7,
      'booking_number': 1010,
      'summary': '1 x Pacific Rim',
      'total': 6.0,
      'date': '02/01/2026 10:20',
    };
    final BookingRecord restored = BookingRecord.fromMap(row);
    expect(restored.id, 7);
    expect(restored.bookingNumber, 1010);
    expect(restored.summary, '1 x Pacific Rim');
    expect(restored.total, 6.0);
    expect(restored.date, '02/01/2026 10:20');
    expect(restored.toMap(), row);
  });

  test('Whole-number SQLite totals become doubles', () {
    final Map<String, Object?> row = booking.toMap();
    row['total'] = 6;
    final BookingRecord restored = BookingRecord.fromMap(row);
    expect(restored.total, 6.0);
    expect(restored.total, isA<double>());
  });
}
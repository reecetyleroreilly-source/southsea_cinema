import 'package:path/path.dart';
import 'package:southsea_cinema/models/booking_record.dart';
import 'package:sqflite/sqflite.dart';

class MovieDataBase {
  static const String _bookingsTable = 'Booking';

  MovieDataBase._internal();
  static final MovieDataBase instance = MovieDataBase._internal();
  static Database? _database;

  void setDatabase(Database? db) {
    _database = db;
  }

  Future<Database> get database async {
    final Database? cachedDatabase = _database;
    if (cachedDatabase != null) {
      return cachedDatabase;
    }
    final Database db = await _initDB('movie_data.db');
    _database = db;
    return db;
  }

  Future<Database> _initDB(String fileName) async {
    final String folder = await getDatabasesPath();
    final String filePath = join(folder, fileName);
    final Database db = await openDatabase(
      filePath,
      version: 1,
      onCreate: _createDB,
    );
    return db;
  }

  Future<void> createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_bookingsTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        booking_number INTEGER NOT NULL,
        summary TEXT NOT NULL,
        total REAL NOT NULL,
        date TEXT NOT NULL
      )
    ''');
  }

  Future<void> _createDB(Database db, int version) async {
    await createTables(db, version);

    await db.insert(_bookingsTable, <String, Object?>{
      'booking_number': 1003,
      'summary': '2 x Iron Man 3 ',
      'total': 15.00,
      'date': '18/04/2026 12:45',
    });

    await db.insert(_bookingsTable, <String, Object?>{
      'booking_number': 1002,
      'summary': '1 x Pacific Rim',
      'total': 6.50,
      'date': '02/03/2026 18:10',
    });

    await db.insert(_bookingsTable, <String, Object?>{
      'booking_number': 1001,
      'summary': '3 x Iron Man 3',
      'total': 22.50,
      'date': '11/01/2026 13:02',
    });
  }

  Future<int> insertBooking(BookingRecord booking) async {
    final Database db = await database;
    final int id = await db.insert(_bookingsTable, booking.toMap());
    return id;
  }

  Future<List<BookingRecord>> getAllbookings() async {
    final Database db = await database;
    final List<Map<String, Object?>> records = await db.query(
      _bookingsTable,
      orderBy: 'booking_number DESC',
    );

    final List<BookingRecord> bookings = [];
    for (final Map<String, Object?> row in records) {
      bookings.add(BookingRecord.fromMap(row));
    }
    return bookings;
  }

    Future<int> getNextBookingNumber() async {
    final Database db = await database;
    final List<Map<String, Object?>> records = await db.rawQuery(
      'SELECT MAX(booking_number) as max_num FROM $_bookingsTable',
    );

    if (records.isEmpty) {
      return 1001;
    }
    final Object? maxValue = records[0]['max_num'];
    if (maxValue == null) {
      return 1001;
    }

    final int currentMax = maxValue as int;
    return currentMax + 1;
  }

    Future<void> close() async {
    final Database? cachedDatabase = _database;
    if (cachedDatabase != null) {
      await cachedDatabase.close();
      _database = null;
    }
  }
}

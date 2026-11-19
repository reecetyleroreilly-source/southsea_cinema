import 'package:path/path.dart';
import 'package:southsea_cinema/models/booking_item.dart';
import 'package:southsea_cinema/models/booking_record.dart';
import 'package:sqflite/sqflite.dart';

class MovieDataBase {
  static const String _bookingsTable = 'Booking';
  static const String _bookingItemsTable = 'BookingItem';
  static const int _databaseVersion = 2;

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
      version: _databaseVersion,
      onConfigure: configureDatabase,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
    return db;
  }

  Future<void> configureDatabase(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
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

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_bookingItemsTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        booking_id INTEGER NOT NULL,
        movie_id TEXT NOT NULL,
        movie_name TEXT NOT NULL,
        price REAL NOT NULL,
        quantity INTEGER NOT NULL CHECK (quantity > 0),
        FOREIGN KEY (booking_id) REFERENCES $_bookingsTable (id)
          ON DELETE CASCADE
      )
    ''');
  }

  Future<void> _upgradeDB(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    await createTables(db, newVersion);
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

  Future<int> insertBookingWithItems(
    BookingRecord booking,
    List<BookingItem> items,
  ) async {
    final Database db = await database;

    return db.transaction<int>((Transaction transaction) async {
      final int bookingId = await transaction.insert(
        _bookingsTable,
        booking.toMap(),
      );

      for (final BookingItem item in items) {
        await transaction.insert(
          _bookingItemsTable,
          item.toMap(bookingId),
        );
      }

      return bookingId;
    });
  }

  Future<List<BookingItem>> getBookingItems(int bookingId) async {
    final Database db = await database;
    final List<Map<String, Object?>> records = await db.query(
      _bookingItemsTable,
      where: 'booking_id = ?',
      whereArgs: <Object?>[bookingId],
      orderBy: 'id ASC',
    );

    final List<BookingItem> items = [];
    for (final Map<String, Object?> row in records) {
      items.add(BookingItem.fromMap(row));
    }
    return items;
  }

  Future<List<BookingRecord>> getAllbookings() async {
    final Database db = await database;
    final List<Map<String, Object?>> records = await db.query(
      _bookingsTable,
      orderBy: 'booking_number DESC',
    );

    final List<BookingRecord> bookings = [];
    for (final Map<String, Object?> row in records) {
      final BookingRecord booking = BookingRecord.fromMap(row);
      final List<BookingItem> items = booking.id == null
          ? <BookingItem>[]
          : await getBookingItems(booking.id!);
      bookings.add(BookingRecord(
        id: booking.id,
        bookingNumber: booking.bookingNumber,
        summary: booking.summary,
        total: booking.total,
        date: booking.date,
        items: items,
      ));
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

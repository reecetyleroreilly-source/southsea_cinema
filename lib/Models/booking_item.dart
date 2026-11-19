class BookingItem {
  final int? id;
  final int? bookingId;
  final String movieId;
  final String movieName;
  final double price;
  final int quantity;

  const BookingItem({
    this.id,
    this.bookingId,
    required this.movieId,
    required this.movieName,
    required this.price,
    required this.quantity,
  });

  Map<String, Object?> toMap(int bookingId) {
    return <String, Object?>{
      'booking_id': bookingId,
      'movie_id': movieId,
      'movie_name': movieName,
      'price': price,
      'quantity': quantity,
    };
  }

  factory BookingItem.fromMap(Map<String, Object?> map) {
    final num priceNumber = map['price'] as num;

    return BookingItem(
      id: map['id'] as int?,
      bookingId: map['booking_id'] as int?,
      movieId: map['movie_id'] as String,
      movieName: map['movie_name'] as String,
      price: priceNumber.toDouble(),
      quantity: map['quantity'] as int,
    );
  }
}

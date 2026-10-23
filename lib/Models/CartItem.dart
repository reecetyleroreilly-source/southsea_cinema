import 'package:southsea_cinema/Models/movie.dart';

class Cartitem {
  final MovieModel movie;
  final int quantity;
  final String date;

  const Cartitem({
    required this.movie,
    required this.quantity,
    required this.date,
  });

  double get lineTotal {
    return movie.price * quantity;
  }
}

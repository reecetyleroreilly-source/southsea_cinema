import 'package:southsea_cinema/Models/movie.dart';

class Cartitem {
  final MovieModel movie;
  final int quantity;

  const Cartitem({
    required this.movie,
    required this.quantity,
  });

  double get LineTotal {
    return movie.price * quantity;
  }
}

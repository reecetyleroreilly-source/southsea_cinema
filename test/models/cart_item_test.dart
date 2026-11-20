import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/cart_item.dart';
import 'package:southsea_cinema/models/movie.dart';

const MovieModel testMovie = MovieModel(
  id: 'ironman3',
  name: 'Iron Man 3',
  description: 'Test movie description',
  date: 'Friday 2nd October 2026 - 9:00am to 11:10am',
  price: 7.50,
  imagePath: 'assets/images/Iron Man Poster.jpg',
  ageRating: '(12a)',
);

void main() {
  group('Cart item model tests', () {
    test('creates a cart item with the given properties', () {
      const Cartitem item = Cartitem(
        movie: testMovie,
        quantity: 2,
        date: 'Friday 2nd October 2026',
      );

      expect(item.movie, testMovie);
      expect(item.quantity, 2);
      expect(item.date, 'Friday 2nd October 2026');
    });

    test('lineTotal equals the movie price for quantity one', () {
      const Cartitem item = Cartitem(
        movie: testMovie,
        quantity: 1,
        date: 'Friday 2nd October 2026',
      );

      expect(item.lineTotal, 7.50);
    });

    test('lineTotal equals the movie price multiplied by quantity', () {
      const Cartitem item = Cartitem(
        movie: testMovie,
        quantity: 3,
        date: 'Friday 2nd October 2026',
      );

      expect(item.lineTotal, closeTo(22.50, 0.001));
    });
  });
}
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/Models/CartItem.dart';
import 'package:southsea_cinema/Models/movie.dart';
import 'package:southsea_cinema/repositories/cart_repository.dart';
//import 'package:southsea_cinema/views/movie_listing.dart';

const MovieModel testMovie1 = MovieModel(
    id: 'ironman3',
    name: 'Iron Man 3',
    description:
        'Marvel Studios Iron Man 3 follows Tony Stark facing a boundless enemy who destroys his personal world, launching him on a harrowing quest for vengeance and survival. Left to rely solely on his ingenuity and instincts, Stark is tested at every turn as he works to protect his loved ones and ultimately confronts whether the man makes the suit or the suit makes the man. You can find the full official synopsis in the referenced source',
    date: 'Friday 2nd October 2026 - 9:00am to 11:10am',
    price: 7.50,
    imagePath: 'assets/images/Iron Man Poster.jpg');

const MovieModel testmovie2 = MovieModel(
    id: 'pacificrim',
    name: 'Pacific Rim',
    description:
        'Earth fights colossal alien monsters called Kaiju, which emerge from an interdimensional portal in the ocean, by using giant robotic mechs called Jaegers controlled by two pilots through a neural bridge',
    date: 'Thursday 12th Decemeber 2026 - 13:00 to 15:11 ',
    price: 6.50,
    imagePath: 'assets/images/Pacific Rim Poster.jpg');

void main() {
  setUp(() {
    CartRepository.instance.clear();
  });

  group('CartRepository tests', () {
    test('Starts with empty basket and zero totals', () {
      final CartRepository cart = CartRepository.instance;
      expect(cart.getItems().length, 0);
      expect(cart.getTotalItems(), 0);
      expect(cart.totalItemCount, 0);
      expect(cart.getSubtotal(), 0.0);
      expect(cart.getTotalDue(), 0.0);
    });

    test('add items and calculates subtotal correctly', () {
      final CartRepository cart = CartRepository.instance;
      const Cartitem item1 = Cartitem(movie: testMovie1, quantity: 2);
      const Cartitem item2 = Cartitem(movie: testmovie2, quantity: 2);

      cart.additem(item1);
      cart.additem(item2);

      expect(cart.getItems().length, 2);
      expect(cart.getTotalItems(), 4);
      expect(cart.totalItemCount, 4);
      expect(cart.getSubtotal(), 28.0);
      expect(cart.getTotalDue(), 28.0);
    });

    test('Remove Item Correctly', () {
      final CartRepository cart = CartRepository.instance;
      const Cartitem item = Cartitem(movie: testMovie1, quantity: 1);

      cart.additem(item);
      expect(cart.getItems().length, 1);

      cart.removeItem(0);
      expect(cart.getItems().length, 0);
      expect(cart.getTotalDue(), 0.0);
    });
  });
}

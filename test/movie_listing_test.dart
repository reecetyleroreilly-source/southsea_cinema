import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/Models/CartItem.dart';
import 'package:southsea_cinema/Models/movie.dart';
import 'package:southsea_cinema/repositories/cart_repository.dart';
import 'package:southsea_cinema/views/basket_screen.dart';
import 'package:southsea_cinema/views/movie_listing.dart';

const MovieModel testMovie = MovieModel(
    id: 'ironman3',
    name: 'Iron Man 3',
    description: 'test description',
    date: 'Friday 2nd October 2026 - 9:00am to 11:10am',
    price: 7.50,
    imagePath: 'assets/images/Iron Man Poster.jpg');

void main() {
  setUp(() {
    CartRepository.instance.clear();
  });

  testWidgets('OrderScreen shows Quantity buttons and ',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: MovieListing(movie: testMovie)),
    );

    expect(find.text(''), findsOneWidget);
  });
}

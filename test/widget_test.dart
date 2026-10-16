import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/Models/movie.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/screens/movie_info_screen.dart';
//import 'package:southsea_cinema/repositories/movie_respository.dart';
//import 'package:southsea_cinema/screens/movie_info_screen.dart';
import 'package:southsea_cinema/views/movie_screen.dart';
//import 'package:southsea_cinema/widgets/movie_card.dart';
//import 'package:southsea_cinema/Models/movie.dart';
//import 'package:southsea_cinema/views/movie_listing.dart';
//import 'package:southsea_cinema/widgets/movie_card.dart';
//import 'package:southsea_cinema/widgets/movie_card.dart';
//import 'package:southsea_cinema/screens/movie_info_screen.dart';
//import 'package:southsea_cinema/widgets/movie_card.dart';

void main() {
  testWidgets('Basic app loading test', (WidgetTester tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());
    expect(find.text('Welcome to Southsea Cinema'), findsOneWidget);
  });

  group('Movie item display test', () {
    testWidgets('display zero movies', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MovieItemDisplay(0, 'Iron Man 3'),
          ),
        ),
      );
      expect(find.text('0 Iron Man 3 movies'), findsOneWidget);
    });
  });

  group('App Smoke Tests', () {
    testWidgets('App display movie screen as home',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp( home: MovieScreen()));
      expect(find.byType(MovieScreen), findsOneWidget);
      expect(find.text('Movie Screen'), findsOneWidget);
    });

    testWidgets('Display movie card with names and prices',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp( home: MovieScreen()));
      expect(find.text('Iron Man 3'), findsOneWidget);
      expect(find.text('Book Tickets - £7.50'), findsOneWidget);
      expect(find.text('Pacific Rim'), findsOneWidget);
      expect(find.text('Book Tickets - £6.50'), findsOneWidget);
      expect(find.text('Book'), findsNWidgets(2));
    });

    testWidgets('Tapping book naviagtion to movie info screen of selected mive',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MovieScreen()));

      await tester.tap(find.text('Book').first);
      await tester.pumpAndSettle();

      expect(find.byType(MovieListing), findsOneWidget);
      expect(find.text('Book Iron Man 3'), findsOneWidget);
      //expect(find.text('0 Iron Man 3 movies'), findsOneWidget);

      final addButton = find.ancestor(
        of: find.text('Add to Basket'),
        matching: find.byType(ElevatedButton),
      );

      await tester.ensureVisible(addButton);
      await tester.pumpAndSettle();
      await tester.tap(addButton);

      // await tester.tap(find.text('Add to Basket'));
      // await tester.pump();
      // expect(find.text('Added to Basket'), findsOneWidget);

      await tester.tap(find.text('Remove'));
      await tester.pump();
      expect(find.text('Empty'), findsOneWidget);
    });

    testWidgets('MovieScreen quantity does not drop below zero',
        (WidgetTester tester) async {
      const movie = MovieModel(
          id: 'ironman3',
          name: 'Iron Man 3',
          description: 'test description',
          date: 'Friday 2nd October 2026 - 9:00am to 11:10am',
          price: 7.50,
          imagePath: 'assets/images/Iron Man Poster.jpg');

      await tester.pumpWidget(
        const MaterialApp(home: Movie1(movie: movie)),
      );

      await tester.tap(find.text('Remove'));
      await tester.pump();
      expect(find.text('Empty'), findsOneWidget);
    });

    testWidgets('Movie Screen quantity does not exceed max quantity',
        (WidgetTester tester) async {
      const movie = MovieModel(
          id: 'ironman3',
          name: 'Iron Man 3',
          description: 'test description',
          date: 'Friday 2nd October 2026 - 9:00am to 11:10am',
          price: 7.50,
          imagePath: 'assets/images/Iron Man Poster.jpg');

      await tester.pumpWidget(const MaterialApp(
        home: Movie1(movie: movie),
      ));

      for (int i = 0; i < 5; i++) {
        await tester.tap(find.text('Add to Basket'));
        await tester.pump();
      }

      expect(find.text('Added to Basket'), findsOneWidget);
    });
  });
}

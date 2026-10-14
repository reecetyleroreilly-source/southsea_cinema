import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
//import 'package:southsea_cinema/repositories/movie_respository.dart';
//import 'package:southsea_cinema/screens/movie_info_screen.dart';
import 'package:southsea_cinema/screens/movie_screen.dart';
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
      await tester.pumpWidget(const SouthseaCinemaApp());
      expect(find.byType(MovieScreen), findsOneWidget);
      expect(find.text('Movie Screen'), findsOneWidget);
    });

    testWidgets('Display movie card with names and prices',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());
      expect(find.text('Iron Man 3'), findsOneWidget);
      expect(find.text('£7.50'), findsOneWidget);
      expect(find.text('Pacific Rim'), findsOneWidget);
      expect(find.text('£7.50'), findsOneWidget);
      expect(find.text('Book'), findsNWidgets(2));
    });

    testWidgets('Tapping book naviagtion to movie info screen of selected mive',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      await tester.tap(find.text('Book').first);
      await tester.pumpAndSettle();

      expect(find.byType(MovieScreen), findsOneWidget);
      expect(find.text('Book'), findsOneWidget);
      expect(find.text('1 ironman 3 movies'), findsOneWidget);
    });

  });
}

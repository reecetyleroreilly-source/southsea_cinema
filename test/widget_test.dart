import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/screens/movie_screen.dart';
//import 'package:southsea_cinema/Models/movie.dart';
//import 'package:southsea_cinema/screens/movie_info_screen.dart';
//import 'package:southsea_cinema/widgets/movie_card.dart';

void main() {
  testWidgets('Basic app loading test', (WidgetTester tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());
    expect(find.text('Welcome to Southsea Cinema'), findsOneWidget);
  });
  group('BookMovieDisplay widget test', () {
    testWidgets('display zero movies', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: MovieItemDisplay(0, 'Iron Man3'),
        ),
      ));
      expect(find.text('0 movie'), findsOneWidget);
    });
  });

  group('App Smoke Test', () {
    testWidgets('App display Movie Screen', (WidgetTester tester) async {
      await tester.pumpWidget(const MovieScreen());
      expect(find.byType(MovieScreen), findsOneWidget);
      expect(find.text('Movie Screen'), findsOneWidget);
    });

    testWidgets('Display Movie card with names and prices',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MovieScreen());
      expect(find.text('Iron Man 3'), findsOneWidget);
      expect(find.text('£7.50'), findsOneWidget);
      expect(find.text('Pacific Rim'), findsOneWidget);
      expect(find.text('£7.50'), findsOneWidget);
      expect(find.text('Book'), findsNWidgets(2));
    });

    testWidgets('Tapping book navigates to movie screen with selected Movie',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MovieScreen());

      await tester.tap(find.text('Book').first);
      await tester.pumpAndSettle();

      expect(find.byType(MovieScreen), findsOneWidget);
      expect(find.text('book'), findsOneWidget);
      expect(find.text('0 Iron Man 3 Movie'), findsOneWidget);
    });
  });
}

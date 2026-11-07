import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/Models/movie.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/views/movie_listing_view.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';
import 'package:flutter/services.dart';

void main() {
  setUp(() {
    rootBundle.clear();
  });

  const MovieModel testMovie = MovieModel(
      id: 'ironman3',
      name: 'Iron Man 3',
      description: 'test description',
      date: 'Friday 2nd October 2026 - 9:00am to 11:10am',
      price: 7.50,
      imagePath: 'assets/images/Iron Man Poster.jpg',
      ageRating: '(12a)');

  testWidgets('Basic app loading test', (WidgetTester tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());
    expect(find.text('Southsea Cinema And Art Centre'), findsOneWidget);
  });

  group('Movie item display test', () {
    testWidgets('display zero movies', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
              body: MovieCard(
            movie: testMovie,
          )),
        ),
      );
      expect(find.text('Book'), findsWidgets);
    });
  });

  group('App Smoke Tests', () {
    testWidgets('App display movie screen as home',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeView()));
      expect(find.byType(HomeView), findsOneWidget);
      expect(find.byIcon(Icons.shopping_basket), findsOneWidget);
    });

    testWidgets('Display movie card with names and prices',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeView()));
      await tester.pumpAndSettle();
      expect(find.text('Iron Man 3'), findsOneWidget);
      expect(find.text('Book Tickets - £7.50'), findsOneWidget);
      expect(find.text('Pacific Rim'), findsOneWidget);
      expect(find.text('Book Tickets - £6.50'), findsOneWidget);
      // expect(find.text('MegaMind'), findsOneWidget);
      // expect(find.text('Book Tickets - £9.99'), findsOneWidget);
      // expect(find.text('Non Existent'), findsOneWidget);
      // expect(find.text('Book Tickets - £0.00'), findsOneWidget);
      expect(find.text('Book'), findsNWidgets(2));

      await tester.scrollUntilVisible(find.text('MegaMind'), 150);
      //expect(find.text('£9.99'), findsOneWidget);
      await tester.scrollUntilVisible(find.text('Non Existent'), 150);
      await tester.pump();
      //expect(find.text('£0.00'), findsOneWidget);
      //expect(find.text('Image unavaliable'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Tapping book naviagtion to movie info screen of selected mive',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MovieCard(
            movie: testMovie,
          ),
        ),
      );

      await tester.tap(find.text('Book').first);
      await tester.pumpAndSettle();

      expect(find.byType(MovieListing), findsOneWidget);
      expect(find.text('Add to Basket'), findsOneWidget);
      //expect(find.text('0 Iron Man 3 movies'), findsOneWidget);

      // final addButton = find.ancestor(
      //   of: find.text('Add to Basket'),
      //   matching: find.byType(ElevatedButton),
      // );

      // await tester.tap(find.text('Add to Basket'));
      // await tester.pump();
      // expect(find.text('Added to Basket'), findsOneWidget);

      // await tester.tap(find.text('Remove'));
      // await tester.pump();
      // expect(find.text('Empty'), findsOneWidget);
    });

    testWidgets('MovieScreen quantity does not drop below zero',
        (WidgetTester tester) async {
      const movie = MovieModel(
          id: 'ironman3',
          name: 'Iron Man 3',
          description: 'test description',
          date: 'Friday 2nd October 2026 - 9:00am to 11:10am',
          price: 7.50,
          imagePath: 'assets/images/Iron Man Poster.jpg',
          ageRating: '(12a)');

      await tester.pumpWidget(
        const MaterialApp(home: Movie(movie: movie)),
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
          imagePath: 'assets/images/Iron Man Poster.jpg',
          ageRating: '(12a)');

      await tester.pumpWidget(const MaterialApp(
        home: MovieListing(movie: movie),
      ));

      for (int i = 0; i < 5; i++) {
        await tester.tap(find.text('Add to Basket'));
        await tester.pump();
      }

      expect(find.text('Please select at least 1 person'), findsOneWidget);
    });
  });

  testWidgets('PrimaryButton renders its label', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            label: 'Checkout',
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.text('Checkout'), findsOneWidget);
  });

  testWidgets('PrimaryButton invokes onPressed when tapped',
      (WidgetTester tester) async {
    bool wasPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            label: 'Checkout',
            onPressed: () {
              wasPressed = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Checkout'));
    await tester.pump();

    expect(wasPressed, isTrue);
  });
}

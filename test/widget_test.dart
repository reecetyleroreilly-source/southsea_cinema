import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/screens/movie_screen.dart';
import 'package:southsea_cinema/Models/movie.dart';
import 'package:southsea_cinema/screens/movie_info_screen.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';

void main() {
  // testWidgets('Basic app loading test', (WidgetTester tester) async {
  //   await tester.pumpWidget(const SouthseaCinemaApp());
  //   expect(find.text('Welcome to Southsea Cinema'), findsOneWidget);
  // });

  group('MovieDisplay', () {
    testWidgets('Display zero Movie with no emoji',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MovieScreen(0, 'Iron Man 3'),
          ),
        ),
      );

      expect(find.text('0 Iron Man 3 movies'), findsOneWidget);
    });
  });
}

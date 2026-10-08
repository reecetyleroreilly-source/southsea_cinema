import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/Models/movie.dart';

void main() {
  group('Movie model tests', () {
    test('create movie instance with given properties', () {
      // Change 'const' to 'final' or 'var'
      final movie = Movie(
        id: 'ironman3',
        name: 'Iron Man 3',
        description:
            'Marvel Studios Iron Man 3 follows Tony Stark facing a boundless',
        date: 'Friday 2nd October 2026 - 9:00am to 11:10am',
        price: 7.50,
        imagePath: 'assets/images/Iron Man Poster.jpg',
      );

      expect(movie.id, 'ironman3');
      expect(movie.name, 'Iron Man 3');
      expect(movie.description,
          'Marvel Studios Iron Man 3 follows Tony Stark facing a boundless');
      expect(movie.date, 'Friday 2nd October 2026 - 9:00am to 11:10am');
      expect(movie.price, 7.50);
      expect(movie.imagePath, 'assets/images/Iron Man Poster.jpg');
    }); // test

    test(
        'formattedPrice returns price prefized with pound sign and two decminals',
        () {
      const movie = Movie(
        id: 'pacificrim',
        name: 'Pacific Rim',
        description: 'Earth fights colossal alien monsters called Kaiju, which emerge from an interdimensional portal in the ocean, by using giant robotic mechs called Jaegers controlled by two pilots through a neural bridge',
        date: 'Thursday 12th Decemeber 2026 - 13:00 to 15:11',
        price: 7.50,
        imagePath: 'assets/images/Pacific Rim Poster.jpg',
      );

      expect(movie.formattedPrice, '£7.50');
    });
  }); // group
}

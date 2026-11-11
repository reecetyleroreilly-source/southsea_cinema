//import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie model tests', () {
    test('create movie instance with given properties', () {
      // Change 'const' to 'final' or 'var'
      final movie = MovieModel(
          id: 'ironman3',
          name: 'Iron Man 3',
          description:
              'Marvel Studios Iron Man 3 follows Tony Stark facing a boundless',
          date: 'Friday 2nd October 2026 - 9:00am to 11:10am',
          price: 7.50,
          imagePath: 'assets/images/Iron Man Poster.jpg',
          ageRating: '(12a)');

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
      const movie = MovieModel(
        id: 'pacificrim',
        name: 'Pacific Rim',
        description:
            'Earth fights colossal alien monsters called Kaiju, which emerge from an interdimensional portal in the ocean, by using giant robotic mechs called Jaegers controlled by two pilots through a neural bridge',
        date: 'Thursday 12th Decemeber 2026 - 13:00 to 15:11',
        price: 7.50,
        imagePath: 'assets/images/Pacific Rim Poster.jpg',
        ageRating: '(12a)',
      );

      expect(movie.formattedPrice, '£7.50');
    });

    test('JSON Conversion preserves every movie fiekd', () {
      final Map<String, dynamic> data = <String, dynamic>{
        'id': 'ironman3',
        'name': 'Iron Man 3',
        'description':
            'Marvel Studios Iron Man 3 follows Tony Stark facing a boundless enemy who destroys his personal world, launching him on a harrowing quest for vengeance and survival. Left to rely solely on his ingenuity and instincts, Stark is tested at every turn as he works to protect his loved ones and ultimately confronts whether the man makes the suit or the suit makes the man. You can find the full official synopsis in the referenced source',
        'date': 'Friday 2nd October 2026 - 9:00am to 11:10am',
        'price': 7.50,
        'imagePath': 'assets/images/Iron Man Poster.jpg',
        'ageRating': '(12a)'
      };

      final MovieModel movies = MovieModel.fromJson(data);
      expect(movies.id, 'ironman3');
      expect(movies.name, 'Iron Man 3');
      expect(movies.description,
          'Marvel Studios Iron Man 3 follows Tony Stark facing a boundless enemy who destroys his personal world, launching him on a harrowing quest for vengeance and survival. Left to rely solely on his ingenuity and instincts, Stark is tested at every turn as he works to protect his loved ones and ultimately confronts whether the man makes the suit or the suit makes the man. You can find the full official synopsis in the referenced source');
      expect(movies.date, 'Friday 2nd October 2026 - 9:00am to 11:10am');
      expect(movies.price, 7.50);
      expect(movies.imagePath, 'assets/images/Iron Man Poster.jpg');
      expect(movies.ageRating, '(12a)');
      expect(movies.toJson(), data);
    });

    test('fromJson accepts a whole number price', () {
      final Map<String, dynamic> data = <String, dynamic>{
        'id': 'test',
        'name': 'test movie',
        'description': 'Test Movie',
        'date': 'friday 2nd October 2026 - 9:00am to 11:10am ',
        'price': 7,
        'imagePath': 'assets/images/Iron Man Poster.jpg',
        'ageRating': '(12a)'
      };
      final MovieModel movies = MovieModel.fromJson(data);
      expect(movies.price, 7.0);
      expect(movies.price, isA<double>());
    });
  }); // group
}

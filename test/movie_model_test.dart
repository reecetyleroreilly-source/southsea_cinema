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
      description: 'Marvel Studios Iron Man 3 follows Tony Stark facing a boundless',
      date: 'Friday 2nd October 2026 - 9:00am to 11:10am',
      price: 7.50,
      imagePath: 'assets/images/Iron Man Poster.jpg',
    );

    expect(movie.id, 'ironman3');
    expect(movie.name, 'Iron Man 3');
    expect(movie.description, 'Marvel Studios Iron Man 3 follows Tony Stark facing a boundless');
    expect(movie.date, 'Friday 2nd October 2026 - 9:00am to 11:10am');
    expect(movie.price, 7.50);
    expect(movie.imagePath, 'assets/images/Iron Man Poster.jpg');
  }); // test
}); // group

}


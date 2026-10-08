import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/Models/movie.dart';
import 'package:southsea_cinema/repositories/movie_respository.dart';

void main() {
  group('repository unit test', () {
    test('getMovie returns two movies', () {
      final MovieRespository respository = MovieRespository();
      final List<Movie> movies = respository.getMovies();

      expect(movies.length, 2);
    });
  });
}

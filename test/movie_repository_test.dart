import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/Models/movie.dart';
import 'package:southsea_cinema/repositories/movie_respository.dart';

void main() {
  group('repository unit test', () {
    test('getMovie returns two movies', () {
      final MovieRespository respository = MovieRespository();
      final List<Movie> movies = respository.getMovies();

      final Movie ironman3 = movies[1];
      expect(ironman3.id, 'ironman3');
      expect(ironman3.name, 'Iron Man 3');
      expect(ironman3.price, 7.50);
      expect(ironman3.imagePath, isNotEmpty);

      final Movie pacificrim = movies[0];
      expect(pacificrim.id, 'pacificrim');
      expect(pacificrim.name, 'Pacific Rim');
      expect(pacificrim.price, 7.50);
      expect(pacificrim.imagePath, isNotEmpty);



      expect(movies.length, 2);
    });
  });
}

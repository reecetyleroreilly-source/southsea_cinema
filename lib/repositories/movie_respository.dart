import 'package:southsea_cinema/Models/movie.dart';

class MovieRespository {
  List<Movie> getMovies() {
    return const [
      Movie(
        id: 'ironman3', 
        name: 'Iron Man 3', 
        description: 'description', 
        imagePath: 'assets/images/Iron Man Poster.jpg')
    ];
  }
}

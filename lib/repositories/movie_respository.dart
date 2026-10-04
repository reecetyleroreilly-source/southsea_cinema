import 'package:southsea_cinema/Models/movie.dart';

class MovieRespository {
  List<Movie> getMovies() {
    return const [
      Movie(
        id: 'ironman3', 
        name: 'Iron Man 3', 
        description: 'Marvel Studios Iron Man 3 follows Tony Stark facing a boundless enemy who destroys his personal world, launching him on a harrowing quest for vengeance and survival. Left to rely solely on his ingenuity and instincts, Stark is tested at every turn as he works to protect his loved ones and ultimately confronts whether the man makes the suit or the suit makes the man. You can find the full official synopsis in the referenced source', 
        date: 'Friday 2nd October 2026 - 9:00am to 11:00am',
        imagePath: 'assets/images/Iron Man Poster.jpg')
    ];
  }
}

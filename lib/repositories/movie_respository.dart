import 'package:southsea_cinema/Models/movie.dart';

class MovieRespository {
  List<Movie> getMovies() {
    return const [
      Movie(
        id: 'ironman3', 
        name: 'Iron Man 3', 
        description: 'Marvel Studios Iron Man 3 follows Tony Stark facing a boundless enemy who destroys his personal world, launching him on a harrowing quest for vengeance and survival. Left to rely solely on his ingenuity and instincts, Stark is tested at every turn as he works to protect his loved ones and ultimately confronts whether the man makes the suit or the suit makes the man. You can find the full official synopsis in the referenced source', 
        date: 'Friday 2nd October 2026 - 9:00am to 11:10am',
        imagePath: 'assets/images/Iron Man Poster.jpg'),

      Movie(
        id: 'pacificrim', 
        name: 'Pacific Rim', 
        description: 'Earth fights colossal alien monsters called Kaiju, which emerge from an interdimensional portal in the ocean, by using giant robotic mechs called Jaegers controlled by two pilots through a neural bridge', 
        date: 'Thursday 12th Decemeber 2026 - 13:00 to 15:11 ', 
        imagePath: 'assets/images/Pacific Rim Poster.jpg')
    ];
  }
}

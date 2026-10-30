import 'package:southsea_cinema/Models/movie.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:southsea_cinema/views/movie_listing.dart';

class MovieRespository {
  List<MovieModel>? _cachedMovies;

  // List<MovieModel> getMovies() {
  //   final List<MovieModel>? cachedMovies = _cachedMovies;
  //   if (cachedMovies != null) {
  //     return cachedMovies;
  //   }
  // }

  List<MovieModel> getMovies() {

    final List<MovieModel>? cachedMovies = _cachedMovies;
    if (cachedMovies != null) {
      return cachedMovies;
    }

    return const [
      MovieModel(
          id: 'ironman3',
          name: 'Iron Man 3',
          description:
              'Marvel Studios Iron Man 3 follows Tony Stark facing a boundless enemy who destroys his personal world, launching him on a harrowing quest for vengeance and survival. Left to rely solely on his ingenuity and instincts, Stark is tested at every turn as he works to protect his loved ones and ultimately confronts whether the man makes the suit or the suit makes the man. You can find the full official synopsis in the referenced source',
          date: 'Friday 2nd October 2026 - 9:00am to 11:10am',
          price: 7.50,
          imagePath: 'assets/images/Iron Man Poster.jpg'),
      MovieModel(
          id: 'pacificrim',
          name: 'Pacific Rim',
          description:
              'Earth fights colossal alien monsters called Kaiju, which emerge from an interdimensional portal in the ocean, by using giant robotic mechs called Jaegers controlled by two pilots through a neural bridge',
          date: 'Thursday 12th Decemeber 2026 - 13:00 to 15:11 ',
          price: 6.50,
          imagePath: 'assets/images/Pacific Rim Poster.jpg')
    ];
  }

  MovieModel? getMoviesByID(String id) {
    for (final movie in getMovies()) {
      if (movie.id == id) {
        return movie;
      }
    }
    return null;
  }

  Future<List<MovieModel>> LoadmovieJSONFromAssets({
    String assetPath = 'assets/data/movieJSON.json',
  }) async {
    final String jsonString = await rootBundle.loadString(assetPath);
    final dynamic decodedData = jsonDecode(jsonString);
    final List<dynamic> jsonList = decodedData as List<dynamic>;
    final List<MovieModel> loadedMovies =[];

    for (final dynamic item in jsonList) {
      final Map<String, dynamic> itemMap = item as Map<String, dynamic>;
      final MovieModel movie = MovieModel.fromJson(itemMap);
      loadedMovies.add(movie);
    }

    _cachedMovies = loadedMovies;
    return loadedMovies;
  }
}

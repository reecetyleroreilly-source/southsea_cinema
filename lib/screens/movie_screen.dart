import 'package:flutter/material.dart';
import 'package:southsea_cinema/Models/movie.dart';
import 'package:southsea_cinema/repositories/movie_respository.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';
import 'package:southsea_cinema/constants.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MovieRespository respository = MovieRespository();
    final List<Movie> movies = respository.getMovies();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movie Screen',
          style: TextStyle(color: cinemaFontWhite),
        ),
      ),
      body: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return MovieCard(movie: movies[index]);
          }),
    );
  }
}

class MovieItemDisplay extends StatelessWidget {
  final int quantity;
  final String itemType;

  const MovieItemDisplay(this.quantity, this.itemType, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text('$quantity $itemType movies');
  }
}

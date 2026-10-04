import 'package:flutter/material.dart';
import 'package:southsea_cinema/Models/movie.dart';
import 'package:southsea_cinema/repositories/movie_respository.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';

class MovieScreen extends StatelessWidget{
  const MovieScreen({super.key};)

  @override
  Widget build(BuildContext context){
    final MovieRespository respository = MovieRespository();
    final List<Movie> movies = respository.getMovies();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Screen'),
      ),

      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index){
          return MovieCard(movie: movies[index]);
        }
        ),

    );
  }
}
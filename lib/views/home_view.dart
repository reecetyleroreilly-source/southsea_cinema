import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/Models/movie.dart';
import 'package:southsea_cinema/repositories/movie_respository.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    final MovieRespository respository = MovieRespository();
    final List<MovieModel> movies = respository.getMovies();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          appTitle,
          style: cinemaHeaderStyle,
        ),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),
      // body: const Center(
      //   child: Padding(
      //     padding: EdgeInsets.all(16.0),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text(
      //           //'Welcome to $appTitle',
      //           'Welcome to Southsea Cinema',
      //           style: TextStyle(
      //             color: cinemaFontWhite,
      //             fontSize: 22,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),

            body: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return MovieCard(movie: movies[index]);
          }),

    );
  }
}

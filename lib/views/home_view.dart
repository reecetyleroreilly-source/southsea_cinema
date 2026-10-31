import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/basket_button.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/Models/movie.dart';
import 'package:southsea_cinema/repositories/movie_respository.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';
import 'package:southsea_cinema/widgets/Settings_button.dart';

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
        actions: const [SettingsButton(), BasketButton()],
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

      body: Align(
        alignment: Alignment.topLeft,
        child: view(),
      ),
    );
  }
}

class view extends StatefulWidget {
  @override
  State<view> createState() => _view();
}

class _view extends State<view> {
  List<MovieModel> _movieList = [];
  bool _loading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    try {
      final MovieRespository respository = MovieRespository();
      final List<MovieModel> movies =
          await respository.LoadmovieJSONFromAssets();
      if (!mounted) {
        return;
      }
      setState(() {
        _movieList = movies;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _errorMessage = 'Could not load avaliable Movies: $error';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final MovieRespository respository = MovieRespository();
    // final List<MovieModel> movies = respository.getMovies();

    final Widget body;
    if (_loading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (_errorMessage.isNotEmpty) {
      body = Center(child: Text(_errorMessage));
    } else {
      body = ListView.builder(
          itemCount: _movieList.length,
          itemBuilder: (context, index) {
            return MovieCard(movie: _movieList[index]);
          });
    }

    return Scaffold(
      //     appBar: AppBar(
      // title: const Text(
      //   appTitle,
      //   style: cinemaHeaderStyle,
      // ),

      // actions: const [SettingsButton(), BasketButton()],

      // ),

      // body: ListView.builder(
      //     itemCount: movies.length,
      //     itemBuilder: (context, index) {
      //       return MovieCard(movie: movies[index]);
      //     }),

      body: body,
    );
  }
}

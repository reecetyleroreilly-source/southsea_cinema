import 'package:flutter/material.dart';
import 'package:southsea_cinema/Models/movie.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieInfoScreen extends StatefulWidget {
  final Movie movie;

  const MovieInfoScreen({
    super.key,
    required this.movie,
  });

  @override
  State<MovieInfoScreen> createState() {
    return _MovieInfoState();
  }
}

class _MovieInfoState extends State<MovieInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book ${widget.movie.name}'),
      ),
      body: Center(child: Column()),
    );
  }
}

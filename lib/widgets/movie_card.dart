import 'package:flutter/material.dart';
import 'package:southsea_cinema/Models/Movie_info.dart';

class MovieCard extends StatelessWidget {
  final MovieInfo movieInfo;

  const MovieCard({super.key, required this.movieInfo});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    )
  }
}

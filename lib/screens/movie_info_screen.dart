import 'package:flutter/material.dart';
import 'package:southsea_cinema/Models/movie.dart';

class MovieInfoScreen extends StatefulWidget {
  final Movie movies;

  const MovieInfoScreen({super.key, required this.movies});

  @override
  State<MovieInfoScreen> createState() {
    return _MovieInfoScreenState();
  }
}

class _MovieInfoScreenState extends State<MovieInfoScreen>{
  
}

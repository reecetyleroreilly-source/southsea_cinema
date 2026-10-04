import 'package:flutter/material.dart';
import 'package:southsea_cinema/Models/movie.dart';
import 'package:southsea_cinema/constants.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF1B1E28),
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Row(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
                Image.asset(
                  movie.imagePath,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Text(
                      movie.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold, color: cinemaFontWhite),
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    Container(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Text(movie.description,
                              style: const TextStyle(color: cinemaFontWhite)),
                          ],
                        ),
                      ),
                    )

                  ],
                )
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text('Book'))
                ],
              )
            ],
          )),
    );
  }
}

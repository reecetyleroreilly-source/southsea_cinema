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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [             
              Row(
                children: [
                   Text(
                      movie.name,
                      style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold, color: cinemaFontWhite),
                    ),
                    const SizedBox(height: 8,),

                    Text('(12a)')
                ],
              ),


              Row(
                spacing: 10.0,
                crossAxisAlignment: CrossAxisAlignment.start, children: [
                Image.asset(
                  movie.imagePath,
                  width: 200,
                  height: 240,
                  fit: BoxFit.cover,
                ),

                
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.description,
                        style: const TextStyle(color: cinemaFontWhite),
                      )
                    ],
                  )
                )
              ]),

              Row(
                children: [
                  Text('Book Tickets', style: const TextStyle(color: cinemaFontWhite))
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 20,
                children: [
                  Text(movie.date),
                  ElevatedButton(onPressed: () {}, child: const Text('Book'))
                ],
              )
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:southsea_cinema/models/movie.dart';
//import 'package:southsea_cinema/screens/movie_info_screen.dart';
import 'package:southsea_cinema/views/movie_listing_view.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).colorScheme.onSurface;

    return Card(
      color: Theme.of(context).colorScheme.surface,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(movie.ageRating)
                ],
              ),
              Row(
                  spacing: 10.0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(movie.imagePath,
                        width: 150,
                        height: 180,
                        fit: BoxFit.cover, errorBuilder: (
                      BuildContext context,
                      Object error,
                      StackTrace? stacktrace,
                    ) {
                      return const SizedBox(
                        width: 80,
                        height: 80,
                        child: Center(child: Text('Image Unavaliable')),
                      );
                    }),
                    Expanded(
                        child: Container(
                      color: Theme.of(context).colorScheme.surface,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.description,
                            style: TextStyle(color: textColor),
                          )
                        ],
                      ),
                    ))
                  ]),
              Row(
                children: [
                  Text(
                    'Book Tickets - ${movie.formattedPrice}',
                    style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  Text(movie.date),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.push(context,
                  //           MaterialPageRoute(builder: (context) {
                  //         return MovieListing(movie: movie);
                  //       }));
                  //     },
                  //     //child: Text('Book - ${movie.name}'))
                  //     child: Text('Book')),

                  SizedBox(
                    width: double.infinity,
                    child:                   
                    PrimaryButton(
                      label: 'Book',
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return MovieListing(movie: movie);
                        }));
                      }),
                  )
                ],
              )
            ],
          )),
    );
  }
}

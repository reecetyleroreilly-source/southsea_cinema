import 'package:flutter/material.dart';
import 'package:southsea_cinema/Models/CartItem.dart';
import 'package:southsea_cinema/Models/movie.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/repositories/movie_respository.dart';
import 'package:southsea_cinema/widgets/Settings_button.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/basket_button.dart';
import 'package:southsea_cinema/repositories/cart_repository.dart';
//import 'package:southsea_cinema/widgets/primary_button.dart';

class MovieListing extends StatelessWidget {
  final MovieModel movie;
  final int maxquantity;
  const MovieListing(
      {super.key, //this.onAdded,
      required this.movie,
      this.maxquantity = 1});

  //final VoidCallback? onAdded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
        actions: const [SettingsButton(), BasketButton()],
      ),
      drawer: const NavDrawer(),
      //body: const SizedBox.shrink(

      body: Align(
        alignment: Alignment.topLeft,
        child: Movie(movie: movie),
      ),
    );
  }
}

class Movie extends StatefulWidget {
  //stateful widget
  //const basket({super.key});

  final MovieModel movie;
  final int maxquantity;

  const Movie({super.key, required this.movie, this.maxquantity = 1});

  @override
  State<Movie> createState() => _Movie();
}

class _Movie extends State<Movie> {
  String _comformationMessage = '';
  int _quantity = 0;

  void _addedBasket() {
    if (_quantity > 0) {
      final Cartitem item = (Cartitem(
          movie: widget.movie, quantity: _quantity, date: widget.movie.date));
      CartRepository.instance.additem(item);
      setState(() {
        _comformationMessage =
            'Added $_quantity ${widget.movie.name} to basket';
      });
    } else {
      setState(() {
        _comformationMessage = 'Please select at least 1 person';
      });
    }
  }

  void _removeBasket() {
    //if (_quantity < widget.maxquantity) {
    setState(() {
      _comformationMessage = "Empty";
      _quantity = _quantity - 1;
    });
    //}
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Align(
            //Main Body of the Movie Page
            alignment: Alignment.topLeft,
            //aligns the code to the top left
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    //Holds the words
                    color: Color(0xFF1B1E28),

                    //height: 900,

                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Column(children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Title(
                                      //is all of the Title of the movie
                                      color: Colors.black,
                                      child: Text(
                                        widget.movie.name,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: cinemaFontWhite),
                                      )),

                                  const SizedBox(
                                      height: 5), //spacing between words
                                ]),
                          ]),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    widget.movie.imagePath,
                                    width: 175,
                                    height: 300,
                                  ),
                                  Expanded(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Movie Description',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),

                                          //const Text(
                                          //'after his personal world is destroyed, Stark undertakes a challenging quest for those responsible, relying on his own ingenuity, instincts, and devices to survive and protect his loved ones. Along the way, he ultimately confronts the question that has long haunted him: whether the man makes the suit or the suit makes the man.'),

                                          Text(widget.movie.description),
                                        ]),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                  height: 5), //used to space out the code
                            ],
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  const Text(
                                      'Select Quntities (Up to 5 in total)',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: cinemaFontWhite)),
                                ]),

                                const SizedBox(height: 5),

                                Row(
                                  children: [
                                    const Text(
                                      'Tickets',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: cinemaFontWhite),
                                    )
                                  ],
                                ),

                                Row(children: [
                                  DropdownMenu<int>(
                                    //Drop Down Menu
                                    initialSelection: _quantity,
                                    onSelected: (int? value) {
                                      if (value != null) {
                                        setState(() {
                                          _quantity = value;
                                        });
                                      }
                                    },

                                    dropdownMenuEntries: [
                                      DropdownMenuEntry(
                                          value: 1, label: '1 Person'),
                                      DropdownMenuEntry(
                                          value: 2, label: '2 People'),
                                      DropdownMenuEntry(
                                          value: 3, label: '3 People'),
                                      DropdownMenuEntry(
                                          value: 4, label: '4 People'),
                                      DropdownMenuEntry(
                                          value: 5, label: '5 People')
                                    ],
                                  ),
                                  Text('Adult - £${widget.movie.price}',
                                      style: TextStyle(
                                          fontSize: 16, color: cinemaFontWhite))
                                ]),

                                //const SizedBox(height: 20),
                                Row(children: [
                                  // SizedBox(
                                  //   width: double.infinity,
                                  //   child: PrimaryButton(label: 'Add to Basket', onPressed: _addedBasket),
                                  // ),

                                  // SizedBox(
                                  //   width: double.infinity,
                                  //   child: PrimaryButton(label: 'Remove', onPressed: _removeBasket),
                                  // ),

                                  // Text(_comformationMessage, style: const TextStyle(fontWeight: FontWeight.bold),),

                                  ElevatedButton(
                                    onPressed:
                                        _addedBasket, // calls on the function and changes the code
                                    child: const Text('Add to Basket'),
                                  ),
                                  ElevatedButton(
                                    onPressed:
                                        _removeBasket, // calls on the function and changes the code
                                    child: const Text('Remove'),
                                  ),
                                  //  ElevatedButton(
                                  //    onPressed:
                                  //        _removeBasket, // calls on the function and changes the code
                                  //    child: const Text('Remove'),
                                  //  ),
                                  Container(
                                    color: Colors.blue,
                                    child: Text(
                                        _comformationMessage), //displayed text
                                  ),
                                ])
                              ])
                        ])))));
  }
}

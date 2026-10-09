import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:southsea_cinema/Models/movie.dart';
import 'package:southsea_cinema/constants.dart';
//import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatelessWidget {
  final Movie movie;
  const MovieListing(
      {super.key, //this.onAdded,
      required this.movie});

  //final VoidCallback? onAdded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
      alignment: Alignment.topLeft,
      child: Movie1(
        movie: movie,
      ),
    ));
  }
}

class Movie1 extends StatefulWidget {
  //stateful widget
  //const basket({super.key});

  final Movie movie;

  const Movie1({
    super.key,
    required this.movie,
  });

  @override
  State<Movie1> createState() => _Movie();
}

class _Movie extends State<Movie1> {
  String added = 'Empty';

  void _addedBasket() {
    setState(() {
      added = "Added to Basket";
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Book ${widget.movie.name}',
              style: TextStyle(color: cinemaFontWhite),
            ),
          ),
          body: Align(
            alignment: Alignment.topLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                
                Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        widget.movie.imagePath,
                                        width: 100,
                                        height: 200,
                                      ),
                  
                  
                                    ],
                                  )
                                ],
                              ),
                        
                      
          
                Column(
                  children: [
                    Container(
                      color: Color(0xFF1B1E28),
                      width: 600,
                      height: 500,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        
                          const SizedBox(height: 15),
                    
                            Text(widget.movie.description, softWrap: true,),
                          
                          const SizedBox(height: 15),
                    
                            const Text('Southsea Cinema Room',
                                style:
                                    TextStyle(fontSize: 16, color: cinemaFontWhite)),
                    
                          const SizedBox(height: 15),
                    
                            Text(widget.movie.date),
                          
                          const SizedBox(height: 15),
                      
                              const Text(
                                  'Please not the Discounts/Membership benefts will be applied once you selected your tickets',
                                  style: TextStyle(
                                      fontSize: 16, color: cinemaFontWhite)),
                           
                          const SizedBox(height: 15),
                      
                            const Text('Select Quntities (Up to 5 in total)',
                                style:
                                    TextStyle(fontSize: 16, color: cinemaFontWhite)),
                          
                          const SizedBox(height: 15),
                      
                              const Text(
                                'Tickets',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: cinemaFontWhite),
                              ),
                            
                          const SizedBox(height: 15),
                      
                          Row(children: [
                            DropdownMenu<int>(
                              //Drop Down Menu
                              initialSelection: 5,
                              //label: const Text('Number of People'),
                      
                              dropdownMenuEntries: [
                                DropdownMenuEntry(value: 1, label: '1 Person'),
                                DropdownMenuEntry(value: 2, label: '2 People'),
                                DropdownMenuEntry(value: 3, label: '3 People'),
                                DropdownMenuEntry(value: 4, label: '4 People'),
                                DropdownMenuEntry(value: 5, label: '5 People')
                              ],
                            ),
                            const Text('Adult - £7.50',
                                style:
                                    TextStyle(fontSize: 16, color: cinemaFontWhite))
                          ]),
                      
                          //const SizedBox(height: 20),
                          Row(children: [
                            ElevatedButton(
                              onPressed:
                                  _addedBasket, // calls on the function and changes the code
                              child: const Text('Add to Basket'),
                            ),
                            Container(
                              color: Colors.blue,
                              child: Text(added), //displayed text
                            )
                          ])
                        ],
                      ),
                    ),
                  ],
                )
              ])
            ),
          
        );
      } else {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                'Book ${widget.movie.name}',
                style: TextStyle(color: cinemaFontWhite),
              ),
            ),
            body: Align(
                alignment: Alignment.topLeft,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                       Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                      widget.movie.imagePath,
                                      width: 100,
                                      height: 200,
                                    ),
                                  ],
                                )
                              ],
                        ),

                      Column(
                        children: [
                          Container(
                            color: Color(0xFF1B1E28),
                            width: 600,
                            height: 500,
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                                                      
                            
                            
                            
                              
                              Text(widget.movie.description, softWrap: true,),
                            
                            const SizedBox(height: 15),
                          
                            const Text('Southsea Cinema Room',
                                style:
                                    TextStyle(fontSize: 16, color: cinemaFontWhite)),
                                                
                            const SizedBox(height: 15),
                                                
                            Text(widget.movie.date),
                                                
                            const SizedBox(height: 15),
                                                
                              const Text(
                                  'Please not the Discounts/Membership benefts will be applied once you selected your tickets',
                                  style: TextStyle(
                                      fontSize: 16, color: cinemaFontWhite)),
                                                 
                            const SizedBox(height: 15),
                            
                            const Text('Select Quntities (Up to 5 in total)',
                                style:
                                    TextStyle(fontSize: 16, color: cinemaFontWhite)),
                                                
                            const SizedBox(height: 15),
                            
                              const Text(
                                'Tickets',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: cinemaFontWhite),
                              ),
                            
                                                
                            const SizedBox(height: 15),
                            
                            Row(children: [
                            DropdownMenu<int>(
                              //Drop Down Menu
                              initialSelection: 5,
                              //label: const Text('Number of People'),
                            
                              dropdownMenuEntries: [
                                DropdownMenuEntry(value: 1, label: '1 Person'),
                                DropdownMenuEntry(value: 2, label: '2 People'),
                                DropdownMenuEntry(value: 3, label: '3 People'),
                                DropdownMenuEntry(value: 4, label: '4 People'),
                                DropdownMenuEntry(value: 5, label: '5 People')
                              ],
                            ),
                            const Text('Adult - £7.50',
                                style:
                                    TextStyle(fontSize: 16, color: cinemaFontWhite))
                                                ]),
                            
                                                //const SizedBox(height: 20),
                                                Row(children: [
                            ElevatedButton(
                              onPressed:
                                  _addedBasket, // calls on the function and changes the code
                              child: const Text('Add to Basket'),
                            ),
                            Container(
                              color: Colors.blue,
                              child: Text(added), //displayed text
                            )
                                                ])
                                              ],),
                          ),
                        ],
                      )
                    ])));
      }
    });
  }
}

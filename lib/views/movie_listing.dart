import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatelessWidget {
  const MovieListing({
    super.key, //this.onAdded,
  });

  //final VoidCallback? onAdded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),
      //body: const SizedBox.shrink(
      body: Align(
        alignment: Alignment.topLeft,
        child: Movie(),
      ),
    );
  }
}

class Movie extends StatefulWidget {
  //stateful widget
  //const basket({super.key});

  @override
  State<Movie> createState() => _Movie();
}

class _Movie extends State<Movie> {
  String added = 'Empty';

  void _added_basket() {
    setState(() {
      added = "Added to Basket";
    });
  }

  @override
  Widget build(BuildContext Context) {
    return Scaffold(
        body: Align(
            //Main Body of the Movie Page
            alignment: Alignment.topLeft, //aligns the code to the top left
            child: Container(
                //Holds the words
                width: 600,
                height: 900,
                child: Column(
                  children: [
                    Title(
                        //is all of the Title of the movie
                        color: Colors.black,
                        child: const Text(
                          'Iron Man 3',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        )),

                    const SizedBox(height: 20), //spacing between words

                    const Text(
                        'Movie Description'), //a description of the movie - Not Needed
                    const Text(
                        'after his personal world is destroyed, Stark undertakes a challenging quest for those responsible, relying on his own ingenuity, instincts, and devices to survive and protect his loved ones. Along the way, he ultimately confronts the question that has long haunted him: whether the man makes the suit or the suit makes the man.'),

                    const SizedBox(height: 20), //used to space out the code

                    const Text('Southsea Cinema Room'),
                    const Text(
                        'Friday 2nd October 2026 - 18:00 - Ends at 20:10 '),

                    const SizedBox(height: 20),

                    const Text(
                        'Please not the Discounts/Membership benefts will be applied once you selected your tickets'),

                    const SizedBox(height: 20),

                    const Text('Select Quntities (Up to 5 in total)'),

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

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed:
                          _added_basket, // calls on the function and changes the code
                      child: const Text('Add to Basket'),
                    ),

                    Container(
                      color: Colors.blue,
                      child: Text(added), //displayed text
                    )

                  ],
                )
              )
            )
          );
  }
}

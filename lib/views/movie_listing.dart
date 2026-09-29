import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatelessWidget {
  const MovieListing({super.key});

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
        body: const SizedBox.shrink(

        child: Align(
          //Main Body of the Movie Page
          alignment: Alignment.topLeft,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                        'Iron Man 3',
                        style:                            TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      
                    )

                  ]
                ),
                
                Row(
                  children: [
                  Text(
                      'after his personal world is destroyed, Stark undertakes a challenging quest for those responsible, relying on his own ingenuity, instincts, and devices to survive and protect his loved ones. Along the way, he ultimately confronts the question that has long haunted him: whether the man makes the suit or the suit makes the man.'),

                  const SizedBox(height: 20),
                  ],
                ),
                  
                Row(
                  children: [
                  DropdownMenu<int>(//DropDown Menu
                    initialSelection: 5,

                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: 1, label: '1 Person'),                      DropdownMenuEntry(value: 2, label: '2 People'),
                      DropdownMenuEntry(value: 3, label: '3 People'),                   
                      DropdownMenuEntry(value: 4, label: '4 People'),
                      DropdownMenuEntry(value: 5, label: '5 People')
                    ],
                  ),

                  SizedBox(height: 20),
                ],
              ),
        
              // Row(
              //   children: [
              //     ElevatedButton(
              //       onPressed: () => print('Added to basket'), //outputs in terminal
              //       child: Text('Add to Basket'),                
              //     ),
              //   ],
              // )
              ],
            )
            
           
              
                
              
            ),
          ),
        );
  }
}



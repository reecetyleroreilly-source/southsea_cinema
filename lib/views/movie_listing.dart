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
      //body: const SizedBox.shrink(
        
      //)

      body: Container(
        alignment: Alignment.topLeft,
        //color: Colors.amber[50],
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text('Iron Man 3'),

            const TextField(
 
              decoration: InputDecoration(
                labelText: 'description here'
              ),
              
            )
          ],

        )

        //child: const Text('Iron Man 3')
        
        
      ),
      

      
      


      
    );

    

  }

  
  

}

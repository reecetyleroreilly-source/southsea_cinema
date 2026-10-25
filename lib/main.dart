import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/views/basket_screen.dart';
//import 'package:southsea_cinema/widgets/basket_button.dart';
//import 'package:southsea_cinema/views/movie_screen.dart';
//import 'package:southsea_cinema/views/movie_listing.dart';
//import 'package:southsea_cinema/views/movie_screen.dart';
import 'package:southsea_cinema/views/settings_screen.dart';

void main() {
  runApp(const SouthseaCinemaApp());
}

//here
class SouthseaCinemaApp extends StatelessWidget {
  const SouthseaCinemaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) {
          return const HomeView();
        },
        '/basket': (BuildContext context){
          return const BasketScreen();
        },
        '/settings': (BuildContext context){
          return const SettingsScreen();
        },
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: cinemaBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: cinemaBrand,
          primary: cinemaBrand,
          surface: cinemaSurface,
        ),
      ),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const HomeView(),

      //   //'/listing': (context) => const MovieListing(),
      //   //'/listing': (context) => const MovieScreen(),
      // },
    );
  }
}

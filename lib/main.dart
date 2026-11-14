import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/views/booking_view.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/views/basket_view.dart';
//import 'package:southsea_cinema/widgets/basket_button.dart';
//import 'package:southsea_cinema/views/movie_screen.dart';
//import 'package:southsea_cinema/views/movie_listing.dart';
//import 'package:southsea_cinema/views/movie_screen.dart';
import 'package:southsea_cinema/views/settings_view.dart';
import 'package:flutter/foundation.dart';
import 'package:southsea_cinema/models/font_size_settings.dart';


bool isSupportedPlatform() {
  if (kIsWeb) {
    return false;
  }
  if (defaultTargetPlatform == TargetPlatform.android) {
    return true;
  }
  return false;
}

void main() {
  if (isSupportedPlatform()) {
    runApp(const SouthseaCinemaApp());
  } else {
    runApp(const UnsupportedPlatformApp());
  }
}

//here
class SouthseaCinemaApp extends StatefulWidget {
  const SouthseaCinemaApp({super.key});

  @override
  State<SouthseaCinemaApp> createState() => _SouthseaCinemaAppState();
}

class _SouthseaCinemaAppState extends State<SouthseaCinemaApp> {
  final FontSizeSettings _fontSizeSettings = FontSizeSettings();

  @override
  void initState() {
    super.initState();
    _fontSizeSettings.load();
  }

  @override
  void dispose() {
    _fontSizeSettings.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _fontSizeSettings,
      builder: (BuildContext context, Widget? child) {
        return FontSizeSettingsScope(
          settings: _fontSizeSettings,
          child: MaterialApp(
            title: appTitle,
            initialRoute: '/',
            routes: <String, WidgetBuilder>{
              '/': (BuildContext context) {
                return const HomeView();
              },
              '/basket': (BuildContext context) {
                return const BasketScreen();
              },
              '/settings': (BuildContext context) {
                return const SettingsScreen();
              },
              '/bookings': (BuildContext context) {
                return const BookingView();
              },
            },
            debugShowCheckedModeBanner: false,
            builder: (BuildContext context, Widget? child) {
              final MediaQueryData mediaQuery = MediaQuery.of(context);
              final double systemTextScale =
                  mediaQuery.textScaler.scale(1.0);
              return MediaQuery(
                data: mediaQuery.copyWith(
                  textScaler: TextScaler.linear(
                    systemTextScale * _fontSizeSettings.textScale,
                  ),
                ),
                child: child ?? const SizedBox.shrink(),
              );
            },
            themeMode: _fontSizeSettings.themeMode,
            theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                iconTheme: IconThemeData(color: cinemaBrandDark),
              ),
              drawerTheme: const DrawerThemeData(
                backgroundColor: Colors.white,
              ),
              colorScheme: ColorScheme.fromSeed(
                seedColor: cinemaBrand,
                primary: cinemaBrandDark,
                surface: Colors.white,
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: cinemaBackground,
              appBarTheme: const AppBarTheme(
                backgroundColor: cinemaSurface,
                foregroundColor: cinemaFontWhite,
                iconTheme: IconThemeData(color: cinemaBrand),
              ),
              drawerTheme: const DrawerThemeData(
                backgroundColor: cinemaBackground,
              ),
              colorScheme: ColorScheme.fromSeed(
                brightness: Brightness.dark,
                seedColor: cinemaBrand,
                primary: cinemaBrand,
                surface: cinemaSurface,
              ),
            ),
          ),
        );
      },
    );
  }
}

class UnsupportedPlatformApp extends StatelessWidget {
  const UnsupportedPlatformApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              'This app saves bookings with SQLite and is set up to run on '
              'Android only. Stop the app and run it on an Android emulator '
              'or device instead.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
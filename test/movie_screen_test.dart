import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/views/basket_view.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/views/settings_sview.dart';
import 'package:flutter/services.dart';
//import 'package:southsea_cinema/widgets/movie_card.dart';

void main() {
  setUp(() {
    rootBundle.clear();
  });

  testWidgets(
      'MovieScreen shows the movie list and a basket button, settings button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomeView()));

    expect(find.byType(HomeView), findsWidgets);
    expect(find.byIcon(Icons.person_outline), findsOneWidget);
    expect(find.byIcon(Icons.shopping_basket), findsOneWidget);
  });

  testWidgets('Taping basket button navigates to Basket Screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) {
            return const HomeView();
          },
          '/basket': (BuildContext context) {
            return const BasketScreen();
          }
        },
      ),
    );
    await tester.tap(find.byIcon(Icons.shopping_basket));
    await tester.pumpAndSettle();

    expect(find.byType(BasketScreen), findsOneWidget);
  });

  testWidgets('Taping basket button navigates to settings Screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) {
            return const HomeView();
          },
          '/settings': (BuildContext context) {
            return const SettingsScreen();
          }
        },
      ),
    );
    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();

    expect(find.byType(SettingsScreen), findsOneWidget);
  });
}

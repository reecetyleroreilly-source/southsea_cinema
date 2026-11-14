import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:southsea_cinema/models/font_size_settings.dart';
import 'package:southsea_cinema/views/settings_view.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  testWidgets('SettingsScreen displays form fields and switches', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));

    expect(find.text('Customer Profile'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.byType(Switch), findsNWidgets(2));
    expect(find.text('Save Settings'), findsOneWidget);
  });

  testWidgets('Toggling switch and saving settings updates state', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));

    final Finder name = find.widgetWithText(TextField, 'Full Name');
    final Finder address = find.widgetWithText(TextField, 'Address');
    final Finder email = find.widgetWithText(TextField, 'Email Address');

    await tester.enterText(name, 'Alex Smith');
    await tester.enterText(address, '10 Elm Road, Portsmouth');
    await tester.enterText(email, 'alex@example.com');

    final Finder switchFinder = find.byType(Switch).first;
    expect(tester.widget<Switch>(switchFinder).value, isFalse);
    await tester.tap(switchFinder);
    await tester.pump();
    expect(tester.widget<Switch>(switchFinder).value, isTrue);



    await tester.enterText(name, 'Reece OReilly');
    await tester.enterText(address, 'Wisborough Road po5 2re');
    await tester.enterText(email, 'RO@gmail.com');

    await tester.tap(find.text('Save Settings'));
    await tester.pump();

    expect(find.text('Settings saved for Reece OReilly'), findsOneWidget);

    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    expect(await prefs.getString(prefName), 'Reece OReilly');
    expect(await prefs.getString(prefAddress), 'Wisborough Road po5 2re');
    expect(
      await prefs.getString(prefEmail),
      'RO@gmail.com',
    );

    expect(await prefs.getBool(prefNewsletter), isTrue);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Reece OReilly'), findsOneWidget);
    expect(find.text('Wisborough Road po5 2re'), findsOneWidget);
    expect(
      find.text('RO@gmail.com'),
      findsOneWidget,
    );

    final Switch reopenedSwithc =
        tester.widget<Switch>(find.byType(Switch).first);
    expect(reopenedSwithc.value, isTrue);

    //expect(find.text('Settings saved for Alex '), findsOneWidget);
  });

  testWidgets('settingsScreen prefils saved settings on open', (
    WidgetTester tester,
  ) async {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.withData(<String, Object>{
      prefName: 'Reece',
      prefAddress: 'Portsmouth Guildhall, po1 2AJ',
      prefEmail: 'R@gmail.com',
      prefNewsletter: true,
    });

    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Reece'), findsOneWidget);
    expect(find.text('Portsmouth Guildhall, po1 2AJ'), findsOneWidget);
    expect(find.text('R@gmail.com'), findsOneWidget);
    final Switch switchWidget =
        tester.widget<Switch>(find.byType(Switch).first);
    expect(switchWidget.value, isTrue);
  });

  testWidgets('Theme switch persists the selected mode', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));

    final Finder themeSwitch = find.byType(Switch).at(1);
    expect(tester.widget<Switch>(themeSwitch).value, isTrue);

    await tester.tap(themeSwitch);
    await tester.pump();

    expect(
      await SharedPreferencesAsync().getString(prefThemeMode),
      ThemeMode.light.name,
    );
    expect(tester.widget<Switch>(find.byType(Switch).at(1)).value, isFalse);
  });
}

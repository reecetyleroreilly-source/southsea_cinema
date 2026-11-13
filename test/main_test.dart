import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';


void main(){
  test('Android is supported', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    expect(SouthseaCinemaApp(), isTrue);
    debugDefaultTargetPlatformOverride = null;
  });
  test('Other platforms are not supported', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    expect(SouthseaCinemaApp(), isFalse);
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    expect(SouthseaCinemaApp(), isFalse);
    debugDefaultTargetPlatformOverride = TargetPlatform.windows;
    expect(SouthseaCinemaApp(), isFalse);
    debugDefaultTargetPlatformOverride = TargetPlatform.linux;
    expect(SouthseaCinemaApp(), isFalse);
    debugDefaultTargetPlatformOverride = null;
  });

    testWidgets('The unsupported platform screen explains what to do',
      (WidgetTester tester) async {
    await tester.pumpWidget(const UnsupportedPlatformApp());
    expect(find.textContaining('Android emulator'), findsOneWidget);
  });
}

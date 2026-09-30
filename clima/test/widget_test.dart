import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vku_lab9/lab_ui.dart';
import 'package:flutter_vku_lab9/screens/city_screen.dart';
import 'package:flutter_vku_lab9/screens/location_screen.dart';

void main() {
  testWidgets('Weather data and city form fit a small screen', (tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(MaterialApp(
      theme: labTheme(),
      home: const LocationScreen(locationWeather: {
        'name': 'Da Nang, Da Nang, Vietnam',
        'main': {'temp': 28},
        'weather': [
          {'id': 0}
        ]
      }),
    ));
    await tester.pumpAndSettle();
    expect(find.text('28°'), findsOneWidget);
    expect(find.text('Da Nang, Da Nang, Vietnam'), findsOneWidget);
    expect(find.text('Thời tiết khá ấm áp'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.ensureVisible(find.text('Tìm thành phố'));
    await tester.tap(find.text('Tìm thành phố'));
    await tester.pumpAndSettle();
    expect(find.byType(CityScreen), findsOneWidget);
    expect(tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull);
    await tester.enterText(find.byType(TextField), '   ');
    await tester.pump();
    expect(tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull);
    await tester.enterText(find.byType(TextField), 'Hanoi');
    await tester.pump();
    expect(tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNotNull);
    expect(tester.takeException(), isNull);
  });
}

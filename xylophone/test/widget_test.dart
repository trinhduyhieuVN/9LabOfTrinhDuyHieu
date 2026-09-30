import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xylophone/main.dart';
import 'package:xylophone/lab_ui.dart';

void main() {
  testWidgets('Small screen layout and main flow', (tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester
        .pumpWidget(MaterialApp(theme: labTheme(), home: const Xylophone()));
    await tester.pumpAndSettle();
    expect(find.text('Xylophone'), findsOneWidget);
    expect(tester.takeException(), isNull);
    expect(find.byType(FilledButton), findsNWidgets(7));
    await tester.ensureVisible(find.text('Si'));
    expect(tester.takeException(), isNull);
  });
}

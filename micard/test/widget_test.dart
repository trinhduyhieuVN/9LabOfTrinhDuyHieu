import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micard/main.dart';

void main() {
  testWidgets('Small screen layout and main flow', (tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MiCardApp());
    await tester.pumpAndSettle();
    expect(find.text('Trịnh Duy Hiếu'), findsOneWidget);
    expect(tester.takeException(), isNull);

    expect(tester.takeException(), isNull);
  });
}

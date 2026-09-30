import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dicee_app1/main.dart';

void main() {
  testWidgets('Small screen layout and main flow', (tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const DiceeApp());
    await tester.pumpAndSettle();
    expect(find.text('TỔNG ĐIỂM'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.ensureVisible(find.text('Tung xúc xắc'));
    await tester.tap(find.text('Tung xúc xắc'));
    await tester.pump();
    expect(find.byType(Image), findsNWidgets(2));
    expect(tester.takeException(), isNull);
  });
}

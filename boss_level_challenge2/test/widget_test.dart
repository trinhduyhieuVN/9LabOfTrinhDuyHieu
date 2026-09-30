import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:boss_level_challenge2/main.dart';
import 'package:boss_level_challenge2/lab_ui.dart';

void main() {
  testWidgets('Small screen layout and main flow', (tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const Destini());
    await tester.pumpAndSettle();
    expect(find.text('Destini'), findsOneWidget);
    expect(tester.takeException(), isNull);
    final first =
        tester
            .widget<Text>(
              find.descendant(
                of: find.byType(LabCard),
                matching: find.byType(Text),
              ),
            )
            .data;
    await tester.ensureVisible(find.byType(FilledButton));
    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    final next =
        tester
            .widget<Text>(
              find.descendant(
                of: find.byType(LabCard),
                matching: find.byType(Text),
              ),
            )
            .data;
    expect(next, isNot(first));
    expect(tester.takeException(), isNull);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/main.dart';

void main() {
  testWidgets('Small screen layout and main flow', (tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const BMICalculator());
    await tester.pumpAndSettle();
    expect(find.text('BMI Calculator'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.ensureVisible(find.text('Tính BMI'));
    await tester.tap(find.text('Tính BMI'));
    await tester.pumpAndSettle();
    expect(find.text('20.8'), findsOneWidget);
    await tester.ensureVisible(find.text('Tính lại'));
    await tester.tap(find.text('Tính lại'));
    await tester.pumpAndSettle();
    expect(find.text('BMI Calculator'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

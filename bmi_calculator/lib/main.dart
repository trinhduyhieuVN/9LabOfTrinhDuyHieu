import 'package:flutter/material.dart';
import 'screens/input_page.dart';
import 'lab_ui.dart';

void main() => runApp(const BMICalculator());

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: labTheme(),
    home: const InputPage(),
  );
}

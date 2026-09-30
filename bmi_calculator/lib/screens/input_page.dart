import 'package:flutter/material.dart';
import '../calculator_brain.dart';
import '../lab_ui.dart';
import 'results_page.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});
  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  int height = 170;
  int weight = 60;
  int age = 20;
  bool male = true;
  Widget counter(
    String label,
    int value,
    VoidCallback? minus,
    VoidCallback? plus,
  ) => LabCard(
    child: Column(
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF607080))),
        Text(
          '$value',
          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 4,
          children: [
            IconButton.filledTonal(
              onPressed: minus,
              tooltip: 'Giảm $label',
              icon: const Icon(Icons.remove),
            ),
            IconButton.filledTonal(
              onPressed: plus,
              tooltip: 'Tăng $label',
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    ),
  );
  @override
  Widget build(BuildContext context) => LabPage(
    title: 'BMI Calculator',
    subtitle: 'Nhập các chỉ số cơ thể của bạn.',
    children: [
      Wrap(
        spacing: 12,
        children: [
          ChoiceChip(
            label: const Text('Nam'),
            selected: male,
            onSelected: (_) => setState(() => male = true),
          ),
          ChoiceChip(
            label: const Text('Nữ'),
            selected: !male,
            onSelected: (_) => setState(() => male = false),
          ),
        ],
      ),
      const SizedBox(height: 20),
      LabCard(
        child: Column(
          children: [
            const Text(
              'CHIỀU CAO',
              style: TextStyle(color: Color(0xFF607080), letterSpacing: 1.5),
            ),
            Text(
              '$height cm',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: height.toDouble(),
              min: 120,
              max: 220,
              divisions: 100,
              label: '$height cm',
              onChanged: (value) => setState(() => height = value.round()),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      LayoutBuilder(
        builder: (context, constraints) {
          final cards = [
            counter(
              'Cân nặng (kg)',
              weight,
              weight > 1 ? () => setState(() => weight--) : null,
              weight < 300 ? () => setState(() => weight++) : null,
            ),
            counter(
              'Tuổi',
              age,
              age > 1 ? () => setState(() => age--) : null,
              age < 120 ? () => setState(() => age++) : null,
            ),
          ];
          if (constraints.maxWidth < 360) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [cards[0], const SizedBox(height: 16), cards[1]],
            );
          }
          return Row(
            children: [
              Expanded(child: cards[0]),
              const SizedBox(width: 16),
              Expanded(child: cards[1]),
            ],
          );
        },
      ),
      const SizedBox(height: 24),
      FilledButton(
        onPressed: () {
          final calculator = CalculatorBrain(height: height, weight: weight);
          final bmi = calculator.calculateBMI();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => ResultsPage(
                    bmiResult: bmi,
                    resultText: calculator.getResult(),
                    interpretation: calculator.getInterpretation(),
                  ),
            ),
          );
        },
        child: const Text('Tính BMI'),
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import '../lab_ui.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({
    super.key,
    required this.interpretation,
    required this.bmiResult,
    required this.resultText,
  });
  final String bmiResult;
  final String resultText;
  final String interpretation;
  @override
  Widget build(BuildContext context) => LabPage(
    title: 'Kết quả BMI',
    subtitle: 'Chỉ số được tính từ chiều cao và cân nặng.',
    children: [
      LabCard(
        child: Column(
          children: [
            const Icon(
              Icons.monitor_heart_outlined,
              color: Color(0xFF147D73),
              size: 44,
            ),
            const SizedBox(height: 16),
            Text(
              bmiResult,
              style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
            ),
            Text(
              resultText,
              style: const TextStyle(fontSize: 22, color: Color(0xFF147D73)),
            ),
            const SizedBox(height: 20),
            Text(
              interpretation,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
      FilledButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Tính lại'),
      ),
    ],
  );
}

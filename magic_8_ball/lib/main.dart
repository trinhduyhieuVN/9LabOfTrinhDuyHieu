import 'dart:math';
import 'package:flutter/material.dart';
import 'lab_ui.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: labTheme(),
    home: const BallPage()));

class BallPage extends StatefulWidget {
  const BallPage({super.key});
  @override
  State<BallPage> createState() => _BallPageState();
}

class _BallPageState extends State<BallPage> {
  final random = Random();
  int ballNumber = 1;
  void ask() => setState(() => ballNumber = random.nextInt(5) + 1);
  @override
  Widget build(BuildContext context) => LabPage(
          title: 'Magic 8 Ball',
          subtitle: 'Nghĩ về một câu hỏi. Để quả cầu trả lời.',
          children: [
            LabCard(
                color: const Color(0xFFEEF0FC),
                child: Column(children: [
                  TextButton(
                      onPressed: ask,
                      child: Image.asset('images/ball$ballNumber.png',
                          semanticLabel: 'Quả cầu trả lời số $ballNumber')),
                  const Text('Chạm vào quả cầu để hỏi lại',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF607080))),
                ])),
            const SizedBox(height: 24),
            FilledButton.icon(
                onPressed: ask,
                icon: const Icon(Icons.auto_awesome),
                label: const Text('Cho tôi một câu trả lời')),
          ]);
}

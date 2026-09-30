import 'dart:math';
import 'package:flutter/material.dart';
import 'lab_ui.dart';

void main() => runApp(const DiceeApp());

class DiceeApp extends StatelessWidget {
  const DiceeApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: labTheme(),
      home: const DicePage());
}

class DicePage extends StatefulWidget {
  const DicePage({super.key});
  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  final random = Random();
  int left = 1;
  int right = 1;
  void roll() => setState(() {
        left = random.nextInt(6) + 1;
        right = random.nextInt(6) + 1;
      });
  @override
  Widget build(BuildContext context) => LabPage(
          title: 'Dicee',
          subtitle: 'Chạm để thử vận may của bạn.',
          children: [
            LabCard(
                child: Column(children: [
              const Text('TỔNG ĐIỂM',
                  style: TextStyle(letterSpacing: 2, color: Color(0xFF607080))),
              Text('${left + right}',
                  style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF147D73))),
              const SizedBox(height: 24),
              Row(children: [
                Expanded(
                    child: Image.asset('images/dice$left.png',
                        semanticLabel: 'Xúc xắc trái: $left')),
                const SizedBox(width: 20),
                Expanded(
                    child: Image.asset('images/dice$right.png',
                        semanticLabel: 'Xúc xắc phải: $right')),
              ]),
            ])),
            const SizedBox(height: 24),
            FilledButton.icon(
                onPressed: roll,
                icon: const Icon(Icons.casino_outlined),
                label: const Text('Tung xúc xắc')),
          ]);
}

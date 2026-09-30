import 'package:flutter/material.dart';
import 'lab_ui.dart';

void main() => runApp(const RichApp());

class RichApp extends StatelessWidget {
  const RichApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: labTheme(),
        home: LabPage(
            title: 'I Am Rich',
            subtitle: 'Một chút lấp lánh cho ngày mới.',
            children: [
              LabCard(
                  child: Column(children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset('assets/images/rich.jpg',
                        height: 260, fit: BoxFit.contain)),
                const SizedBox(height: 24),
                const Text('Shine in your own way',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                const Text('Giá trị bắt đầu từ chính bạn.',
                    style: TextStyle(color: Color(0xFF607080))),
              ]))
            ]),
      );
}

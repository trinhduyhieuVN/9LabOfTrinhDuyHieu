import 'package:flutter/material.dart';
import 'lab_ui.dart';

void main() => runApp(const MiCardApp());

class MiCardApp extends StatelessWidget {
  const MiCardApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: labTheme(),
        home: const LabPage(
            title: 'Mi Card',
            subtitle: 'Xin chào, rất vui được kết nối!',
            children: [
              LabCard(
                  child: Column(children: [
                CircleAvatar(
                    radius: 48,
                    backgroundColor: Color(0xFFE0F2EF),
                    child: Text('DH',
                        style: TextStyle(
                            fontSize: 32,
                            color: Color(0xFF147D73),
                            fontWeight: FontWeight.bold))),
                SizedBox(height: 20),
                Text('Trịnh Duy Hiếu',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
                SizedBox(height: 8),
                Text('Flutter • Mobile Developer',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF147D73), fontSize: 16)),
                SizedBox(height: 24),
                Divider(),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.code_rounded),
                    title: Text('9 bài thực hành'),
                    subtitle: Text('Lập trình đa nền tảng')),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.auto_awesome_outlined),
                    title: Text('Học qua từng ứng dụng'),
                    subtitle: Text('Đơn giản • Rõ ràng • Dễ sử dụng')),
              ]))
            ]),
      );
}

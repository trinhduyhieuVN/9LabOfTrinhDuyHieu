import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'lab_ui.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: labTheme(),
    home: const Xylophone()));

class Xylophone extends StatefulWidget {
  const Xylophone({super.key});
  @override
  State<Xylophone> createState() => _XylophoneState();
}

class _XylophoneState extends State<Xylophone> {
  final player = AudioPlayer();
  static const notes = ['Đô', 'Rê', 'Mi', 'Fa', 'Sol', 'La', 'Si'];
  static const colors = [
    Color(0xFFB64949),
    Color(0xFFAA581D),
    Color(0xFF8C701C),
    Color(0xFF3B7A52),
    Color(0xFF287D80),
    Color(0xFF3F68A8),
    Color(0xFF8053A1)
  ];
  Future<void> play(int index) async {
    try {
      await player.play(AssetSource('note${index + 1}.wav'));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Không thể phát âm thanh. Hãy thử lại.')));
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LabPage(
        title: 'Xylophone',
        subtitle: 'Bảy nốt nhạc, một giai điệu của riêng bạn.',
        children: List.generate(
            7,
            (index) => Padding(
                  padding: EdgeInsets.fromLTRB(index * 5.0, 0, index * 5.0, 10),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: colors[index],
                        foregroundColor: Colors.white,
                        minimumSize: const Size(48, 64)),
                    onPressed: () => play(index),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(notes[index],
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          const Icon(Icons.music_note),
                        ]),
                  ),
                )),
      );
}

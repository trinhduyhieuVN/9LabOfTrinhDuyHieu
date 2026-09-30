import 'package:flutter/material.dart';
import 'story_brain.dart';
import 'lab_ui.dart';

void main() => runApp(const Destini());

class Destini extends StatelessWidget {
  const Destini({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: labTheme(),
    home: const StoryPage(),
  );
}

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});
  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final storyBrain = StoryBrain();
  @override
  Widget build(BuildContext context) => LabPage(
    title: 'Destini',
    subtitle: 'Mỗi lựa chọn mở ra một câu chuyện.',
    children: [
      LabCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.auto_stories_outlined,
              color: Color(0xFF147D73),
              size: 36,
            ),
            const SizedBox(height: 20),
            Text(
              storyBrain.getStory(),
              style: const TextStyle(fontSize: 19, height: 1.7),
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
      FilledButton(
        onPressed: () => setState(() => storyBrain.nextStory(1)),
        child: Text(storyBrain.getChoice1(), textAlign: TextAlign.center),
      ),
      if (storyBrain.buttonShouldBeVisible()) ...[
        const SizedBox(height: 12),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () => setState(() => storyBrain.nextStory(2)),
          child: Text(storyBrain.getChoice2(), textAlign: TextAlign.center),
        ),
      ],
    ],
  );
}

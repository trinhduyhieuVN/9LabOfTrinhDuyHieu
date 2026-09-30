import 'package:flutter/material.dart';
import '../data/quizz_data.dart';
import '../lab_ui.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  int? selected;
  void next() => setState(() {
    if (selected == quizQuestions[currentQuestionIndex].correctAnswerIndex) {
      score++;
    }
    currentQuestionIndex++;
    selected = null;
  });
  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex >= quizQuestions.length) {
      return LabPage(
        title: 'Kết quả',
        subtitle: 'Bạn đã hoàn thành bài trắc nghiệm.',
        children: [
          LabCard(
            child: Column(
              children: [
                const Icon(
                  Icons.emoji_events_outlined,
                  size: 64,
                  color: Color(0xFF147D73),
                ),
                const SizedBox(height: 20),
                Text(
                  '$score / ${quizQuestions.length}',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('câu trả lời chính xác'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed:
                () => setState(() {
                  currentQuestionIndex = 0;
                  score = 0;
                  selected = null;
                }),
            child: const Text('Thử lại'),
          ),
        ],
      );
    }
    final question = quizQuestions[currentQuestionIndex];
    return LabPage(
      title: 'Quizzler',
      subtitle:
          'Câu ${currentQuestionIndex + 1} / ${quizQuestions.length} • Chọn một đáp án',
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            minHeight: 8,
            value: currentQuestionIndex / quizQuestions.length,
          ),
        ),
        const SizedBox(height: 24),
        LabCard(
          child: Text(
            question.question,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ...List.generate(
          question.options.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(18),
                backgroundColor:
                    selected == index ? const Color(0xFFE0F2EF) : Colors.white,
                side: BorderSide(
                  color:
                      selected == index
                          ? const Color(0xFF147D73)
                          : const Color(0xFFD6DFE6),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () => setState(() => selected = index),
              child: Row(
                children: [
                  Icon(
                    selected == index
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      question.options[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        FilledButton(
          onPressed: selected == null ? null : next,
          child: Text(
            currentQuestionIndex == quizQuestions.length - 1
                ? 'Xem kết quả'
                : 'Câu tiếp theo',
          ),
        ),
      ],
    );
  }
}

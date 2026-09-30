import 'package:flutter/material.dart';
import '../lab_ui.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});
  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  final controller = TextEditingController();
  void submit() {
    final name = controller.text.trim();
    if (name.isNotEmpty) Navigator.pop(context, name);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LabPage(
        title: 'Tìm thành phố',
        subtitle: 'Nhập tên nơi bạn muốn xem thời tiết.',
        children: [
          TextField(
            controller: controller,
            autofocus: true,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => submit(),
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              labelText: 'Tên thành phố',
              hintText: 'Ví dụ: Da Nang',
              prefixIcon: Icon(Icons.location_city),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: controller.text.trim().isEmpty ? null : submit,
            child: const Text('Xem thời tiết'),
          ),
        ],
      );
}

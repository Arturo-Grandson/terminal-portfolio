import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';

class TerminalInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String currentDirectory;
  final Function(String) onSubmitted;

  const TerminalInput({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.currentDirectory,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'arturo@portfolio:$currentDirectory\$',
          style: AppTextStyles.terminalPrompt,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            style: AppTextStyles.terminalText,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'type a command...',
              hintStyle: AppTextStyles.terminalPrompt,
            ),
            onSubmitted: onSubmitted,
          ),
        ),
      ],
    );
  }
}

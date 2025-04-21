import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';

class TerminalLine extends StatelessWidget {
  final String command;
  final String response;

  const TerminalLine({
    super.key,
    required this.command,
    required this.response,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      Text(command, style: AppTextStyles.terminalPrompt),
    ];

    if (response.isNotEmpty) {
      children.addAll([
        const SizedBox(height: 5),
        Text(response, style: AppTextStyles.terminalText),
      ]);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}

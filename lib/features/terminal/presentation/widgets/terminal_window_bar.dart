import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class TerminalWindowBar extends StatelessWidget {
  final String title;

  const TerminalWindowBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        color: AppColors.terminalBar,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildWindowButton(Colors.red),
              const SizedBox(width: 6),
              _buildWindowButton(Colors.amber),
              const SizedBox(width: 6),
              _buildWindowButton(Colors.green),
            ],
          ),
          Text(title, style: AppTextStyles.terminalTitle),
          const SizedBox(width: 60),
        ],
      ),
    );
  }

  Widget _buildWindowButton(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
